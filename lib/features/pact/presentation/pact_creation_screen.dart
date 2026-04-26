import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../domain/models/pact.dart';
import 'providers/pact_creation_providers.dart';

// ── Entry point ───────────────────────────────────────────────────────────────

class PactCreationScreen extends ConsumerStatefulWidget {
  const PactCreationScreen({super.key});

  @override
  ConsumerState<PactCreationScreen> createState() => _PactCreationScreenState();
}

class _PactCreationScreenState extends ConsumerState<PactCreationScreen> {
  final _pageController = PageController();
  int _currentStep = 0;
  static const int _totalSteps = 5;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    final form = ref.read(pactFormNotifierProvider);
    // Validate before advancing from step 1 (action + duration + cadence)
    if (_currentStep == 1 && !form.isStep2Valid) {
      ref.read(pactFormNotifierProvider.notifier).markValidationAttempted();
      return;
    }
    // Validate if/then pair before advancing from step 2
    if (_currentStep == 2 && !form.isIfThenValid) {
      ref.read(pactFormNotifierProvider.notifier).markValidationAttempted();
      return;
    }
    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _showDiscardDialog() async {
    final leave = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Leave this experiment?'),
        content: const Text(
            'Your progress won\'t be saved.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Keep writing'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(ctx).colorScheme.error,
            ),
            child: const Text('Not now'),
          ),
        ],
      ),
    );
    if ((leave ?? false) && mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _submit() async {
    final form = ref.read(pactFormNotifierProvider);
    await ref
        .read(createPactNotifierProvider.notifier)
        .submit(form);
  }

  @override
  Widget build(BuildContext context) {
    // Listen for successful creation → pop back to dashboard
    ref.listen<CreatePactStatus>(createPactNotifierProvider, (_, next) {
      if (next is CreatePactSuccess && mounted) {
        Navigator.of(context).pop();
      }
    });

    final status = ref.watch(createPactNotifierProvider);
    final isSubmitting = status is CreatePactLoading;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        if (_currentStep > 0) {
          _prevStep();
        } else {
          await _showDiscardDialog();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: _currentStep == 0
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: _showDiscardDialog,
                )
              : IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: _prevStep,
                ),
          title: _StepIndicator(
            currentStep: _currentStep,
            totalSteps: _totalSteps,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  _Step1Curiosity(),
                  _Step2PactAction(),
                  _Step3IfThen(),
                  _Step4Temperature(),
                  _Step5Review(),
                ],
              ),
            ),
            if (status is CreatePactError)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                child: Text(
                  status.message,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            _BottomBar(
              currentStep: _currentStep,
              isSubmitting: isSubmitting,
              onNext: _nextStep,
              onSubmit: _submit,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Step indicator ────────────────────────────────────────────────────────────

class _StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const _StepIndicator({
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalSteps, (i) {
        final isActive = i == currentStep;
        final isPast = i < currentStep;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 20 : 6,
          height: 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: isActive
                ? AppColors.primary
                : isPast
                    ? AppColors.primary.withValues(alpha: 0.45)
                    : Colors.grey.withValues(alpha: 0.35),
          ),
        );
      }),
    );
  }
}

// ── Bottom bar ────────────────────────────────────────────────────────────────

class _BottomBar extends ConsumerWidget {
  final int currentStep;
  final bool isSubmitting;
  final VoidCallback onNext;
  final VoidCallback onSubmit;

  const _BottomBar({
    required this.currentStep,
    required this.isSubmitting,
    required this.onNext,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLastStep = currentStep == 4;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(24, 8, 24, 16 + bottomPadding),
      child: isLastStep
          ? _ReviewButtons(isSubmitting: isSubmitting, onSubmit: onSubmit)
          : FilledButton(
              onPressed: onNext,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
              ),
              child: const Text(
                'Next',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
    );
  }
}

class _ReviewButtons extends ConsumerWidget {
  final bool isSubmitting;
  final VoidCallback onSubmit;

  const _ReviewButtons({
    required this.isSubmitting,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FilledButton(
          onPressed: isSubmitting ? null : onSubmit,
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.black,
          ),
          child: isSubmitting
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.black54,
                  ),
                )
              : const Text(
                  'Start my experiment',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: null, // TODO (Epic 6): save to backlog
          child: Text(
            'Save to backlog',
            style: TextStyle(color: Colors.grey.withValues(alpha: 0.45)),
          ),
        ),
      ],
    );
  }
}

// ── Step 1 — Curiosity / Hypothesis ──────────────────────────────────────────

class _Step1Curiosity extends ConsumerWidget {
  const _Step1Curiosity();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hypothesis =
        ref.watch(pactFormNotifierProvider.select((s) => s.hypothesis));

    return _StepScaffold(
      stepLabel: 'Step 1 of 5',
      title: 'What are you curious about?',
      subtitle:
          'Optional — state a hypothesis or the question you want to explore.',
      child: TextField(
        autofocus: true,
        maxLines: 4,
        maxLength: 280,
        keyboardType: TextInputType.multiline,
        textCapitalization: TextCapitalization.sentences,
        decoration: const InputDecoration(
          hintText: 'e.g. "I wonder if a short walk after lunch helps me focus…"',
          border: OutlineInputBorder(),
          alignLabelWithHint: true,
        ),
        controller: TextEditingController.fromValue(
          TextEditingValue(
            text: hypothesis,
            selection: TextSelection.collapsed(offset: hypothesis.length),
          ),
        ),
        onChanged:
            ref.read(pactFormNotifierProvider.notifier).updateHypothesis,
      ),
    );
  }
}

// ── Step 2 — PACT Action ──────────────────────────────────────────────────────

class _Step2PactAction extends ConsumerWidget {
  const _Step2PactAction();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(pactFormNotifierProvider);
    final notifier = ref.read(pactFormNotifierProvider.notifier);
    final showErrors = form.showErrors;

    return _StepScaffold(
      stepLabel: 'Step 2 of 5',
      title: 'Define your action',
      subtitle: 'A short, concrete action you\'ll repeat on a schedule.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Action field
          TextField(
            autofocus: true,
            maxLength: 120,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: 'I will…',
              hintText: 'e.g. "meditate for 5 minutes"',
              border: const OutlineInputBorder(),
              errorText: showErrors && !form.isActionValid
                  ? 'At least 5 characters required'
                  : null,
            ),
            controller: TextEditingController.fromValue(
              TextEditingValue(
                text: form.action,
                selection: TextSelection.collapsed(offset: form.action.length),
              ),
            ),
            onChanged: notifier.updateAction,
          ),
          const SizedBox(height: 20),

          // Duration row
          Row(
            children: [
              SizedBox(
                width: 80,
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    _MaxValueFormatter(3650),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Days',
                    border: const OutlineInputBorder(),
                    errorText: showErrors && !form.isDurationValid ? '' : null,
                  ),
                  controller: TextEditingController.fromValue(
                    TextEditingValue(
                      text: form.durationDays.toString(),
                      selection: TextSelection.collapsed(
                          offset: form.durationDays.toString().length),
                    ),
                  ),
                  onChanged: (v) {
                    final parsed = int.tryParse(v);
                    if (parsed != null) notifier.updateDurationDays(parsed);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  form.durationLabel.isEmpty
                      ? '—'
                      : '≈ ${form.durationLabel}  ·  ${form.durationTrials} ${form.durationTrials == 1 ? 'trial' : 'trials'}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Cadence selector
          _CadenceSelector(form: form, notifier: notifier),
        ],
      ),
    );
  }
}

// ── Cadence selector ──────────────────────────────────────────────────────────

class _CadenceSelector extends StatelessWidget {
  final PactFormState form;
  final PactFormNotifier notifier;

  const _CadenceSelector({required this.form, required this.notifier});

  static const _labels = {
    PactCadence.daily: 'Daily',
    PactCadence.weekly: 'Weekly',
    PactCadence.biweekly: 'Bi-Weekly',
    PactCadence.monthly: 'Monthly',
  };

  void _openPicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _CadencePickerSheet(
        selected: form.cadence,
        onSelected: (c) {
          notifier.updateCadence(c);
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _openPicker(context),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade700),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Text(
                  _labels[form.cadence] ?? 'Daily',
                  style: const TextStyle(fontSize: 16),
                ),
                const Spacer(),
                const Icon(Icons.expand_more),
              ],
            ),
          ),
        ),
        if (form.cadence != PactCadence.daily) ...[
          const SizedBox(height: 12),
          _DayOfWeekRow(
            selected: form.dayOfWeek,
            onSelected: notifier.updateDayOfWeek,
          ),
        ],
      ],
    );
  }
}

class _CadencePickerSheet extends StatelessWidget {
  final PactCadence selected;
  final ValueChanged<PactCadence> onSelected;

  const _CadencePickerSheet({
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    const options = [
      (PactCadence.daily, 'Daily', 'Every day'),
      (PactCadence.weekly, 'Weekly', 'Once a week'),
      (PactCadence.biweekly, 'Bi-Weekly', 'Every two weeks'),
      (PactCadence.monthly, 'Monthly', 'Once a month'),
    ];

    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade600,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          for (final (cadence, label, sub) in options)
            ListTile(
              title: Text(label),
              subtitle: Text(sub,
                  style: TextStyle(
                      color: Colors.grey.shade500, fontSize: 12)),
              trailing: cadence == selected
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
              onTap: () => onSelected(cadence),
            ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ── Day-of-week row ───────────────────────────────────────────────────────────

class _DayOfWeekRow extends StatelessWidget {
  final int? selected; // 1 = Mon … 7 = Sun
  final ValueChanged<int> onSelected;

  const _DayOfWeekRow({required this.selected, required this.onSelected});

  static const _days = ['M', 'Tu', 'W', 'Th', 'Fr', 'Sa', 'Su'];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (i) {
        final dow = i + 1; // 1-based weekday
        final isSelected = selected == dow;
        return GestureDetector(
          onTap: () => onSelected(dow),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? AppColors.primary
                  : Colors.grey.withValues(alpha: 0.15),
            ),
            alignment: Alignment.center,
            child: Text(
              _days[i],
              style: TextStyle(
                fontSize: 12,
                fontWeight:
                    isSelected ? FontWeight.w700 : FontWeight.w400,
                color: isSelected ? Colors.black : Colors.grey.shade400,
              ),
            ),
          ),
        );
      }),
    );
  }
}

// ── Step 3 — If / Then ────────────────────────────────────────────────────────

class _Step3IfThen extends ConsumerWidget {
  const _Step3IfThen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(pactFormNotifierProvider);
    final notifier = ref.read(pactFormNotifierProvider.notifier);
    final showErrors = form.showErrors;
    final pairError = showErrors && !form.isIfThenValid
        ? 'Fill in both fields or leave both empty'
        : null;

    return _StepScaffold(
      stepLabel: 'Step 3 of 5',
      title: 'Add an if/then trigger',
      subtitle:
          'Optional — link your action to a specific cue or context.',
      child: Column(
        children: [
          TextField(
            maxLength: 120,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: 'If…',
              hintText: 'e.g. "after I make coffee"',
              border: const OutlineInputBorder(),
              errorText: pairError,
            ),
            controller: TextEditingController.fromValue(
              TextEditingValue(
                text: form.ifCondition,
                selection: TextSelection.collapsed(
                    offset: form.ifCondition.length),
              ),
            ),
            onChanged: notifier.updateIfCondition,
          ),
          const SizedBox(height: 16),
          TextField(
            maxLength: 120,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: 'Then I will…',
              hintText: 'e.g. "meditate for 5 minutes"',
              border: const OutlineInputBorder(),
              errorText: pairError != null ? '' : null,
            ),
            controller: TextEditingController.fromValue(
              TextEditingValue(
                text: form.thenAction,
                selection: TextSelection.collapsed(
                    offset: form.thenAction.length),
              ),
            ),
            onChanged: notifier.updateThenAction,
          ),
        ],
      ),
    );
  }
}

// ── Step 4 — Temperature ──────────────────────────────────────────────────────

class _Step4Temperature extends ConsumerWidget {
  const _Step4Temperature();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final temperature = ref
        .watch(pactFormNotifierProvider.select((s) => s.temperature));
    final notifier = ref.read(pactFormNotifierProvider.notifier);

    return _StepScaffold(
      stepLabel: 'Step 4 of 5',
      title: 'How curious are you?',
      subtitle:
          'Optional — how fired up are you about this experiment right now?',
      child: Column(
        children: [
          _TempTile(
            value: CuriosityTemperature.cold,
            label: 'Cold',
            description: 'Mildly curious — worth trying',
            icon: Icons.ac_unit,
            color: Colors.lightBlue,
            selected: temperature,
            onTap: notifier.updateTemperature,
          ),
          const SizedBox(height: 12),
          _TempTile(
            value: CuriosityTemperature.warm,
            label: 'Warm',
            description: 'Genuinely interested — excited to see what happens',
            icon: Icons.wb_sunny_outlined,
            color: Colors.orange,
            selected: temperature,
            onTap: notifier.updateTemperature,
          ),
          const SizedBox(height: 12),
          _TempTile(
            value: CuriosityTemperature.fiery,
            label: 'Fiery',
            description: 'Burning to know — this feels important',
            icon: Icons.local_fire_department_outlined,
            color: Colors.deepOrange,
            selected: temperature,
            onTap: notifier.updateTemperature,
          ),
        ],
      ),
    );
  }
}

class _TempTile extends StatelessWidget {
  final CuriosityTemperature value;
  final String label;
  final String description;
  final IconData icon;
  final Color color;
  final CuriosityTemperature? selected;
  final ValueChanged<CuriosityTemperature?> onTap;

  const _TempTile({
    required this.value,
    required this.label,
    required this.description,
    required this.icon,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selected == value;

    return GestureDetector(
      onTap: () => onTap(isSelected ? null : value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? color.withValues(alpha: 0.8)
                : Colors.grey.withValues(alpha: 0.25),
            width: isSelected ? 1.5 : 1,
          ),
          color: isSelected
              ? color.withValues(alpha: 0.12)
              : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? color : Colors.grey.shade600),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isSelected ? color : null,
                      )),
                  const SizedBox(height: 2),
                  Text(description,
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500)),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: color, size: 18),
          ],
        ),
      ),
    );
  }
}

// ── Step 5 — Review ───────────────────────────────────────────────────────────

class _Step5Review extends ConsumerWidget {
  const _Step5Review();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(pactFormNotifierProvider);
    final colorAsync = ref.watch(nextPactColorProvider);
    final color = colorAsync.asData?.value ?? AppColors.pactPalette[0];
    final dateFormat = DateFormat('MMM d, yyyy');

    return _StepScaffold(
      stepLabel: 'Step 5 of 5',
      title: 'Review your experiment',
      subtitle: 'Everything look right?',
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: color.withValues(alpha: 0.35), width: 1.5),
          color: color.withValues(alpha: 0.06),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.15),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Action
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withValues(alpha: 0.85),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'I will ${form.action.isEmpty ? '—' : form.action.trim()}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            _ReviewRow(
              label: 'Cadence',
              value: _cadenceLabel(form.cadence),
            ),
            _ReviewRow(
              label: 'Duration',
              value:
                  '${form.durationLabel} · ${form.durationTrials} trials',
            ),
            _ReviewRow(
              label: 'Starts',
              value: dateFormat.format(form.startDate),
            ),
            _ReviewRow(
              label: 'Ends',
              value: dateFormat.format(form.endDate),
            ),

            if (form.ifCondition.trim().isNotEmpty) ...[
              const SizedBox(height: 8),
              const Divider(height: 1),
              const SizedBox(height: 8),
              _ReviewRow(
                  label: 'If', value: form.ifCondition.trim()),
              _ReviewRow(
                  label: 'Then', value: form.thenAction.trim()),
            ],

            if (form.hypothesis.trim().isNotEmpty) ...[
              const SizedBox(height: 8),
              const Divider(height: 1),
              const SizedBox(height: 8),
              Text(
                '"${form.hypothesis.trim()}"',
                style: TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade400),
              ),
            ],

            if (form.temperature != null) ...[
              const SizedBox(height: 8),
              const Divider(height: 1),
              const SizedBox(height: 8),
              _ReviewRow(
                label: 'Curiosity',
                value: _temperatureLabel(form.temperature!),
              ),
            ],
          ],
        ),
      ),
    );
  }

  static String _cadenceLabel(PactCadence c) => switch (c) {
        PactCadence.daily => 'Daily',
        PactCadence.weekly => 'Weekly',
        PactCadence.biweekly => 'Bi-Weekly',
        PactCadence.monthly => 'Monthly',
      };

  static String _temperatureLabel(CuriosityTemperature t) => switch (t) {
        CuriosityTemperature.cold => '❄️ Cold',
        CuriosityTemperature.warm => '☀️ Warm',
        CuriosityTemperature.fiery => '🔥 Fiery',
      };
}

class _ReviewRow extends StatelessWidget {
  final String label;
  final String value;

  const _ReviewRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(
            width: 72,
            child: Text(
              label,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 13)),
          ),
        ],
      ),
    );
  }
}

// ── Shared step scaffold ──────────────────────────────────────────────────────

class _StepScaffold extends StatelessWidget {
  final String stepLabel;
  final String title;
  final String subtitle;
  final Widget child;

  const _StepScaffold({
    required this.stepLabel,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stepLabel,
            style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade500,
                letterSpacing: 0.8),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style:
                TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }
}

// ── Input formatter ───────────────────────────────────────────────────────────

class _MaxValueFormatter extends TextInputFormatter {
  final int max;
  const _MaxValueFormatter(this.max);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final parsed = int.tryParse(newValue.text);
    if (parsed == null) return newValue;
    if (parsed > max) return oldValue;
    return newValue;
  }
}
