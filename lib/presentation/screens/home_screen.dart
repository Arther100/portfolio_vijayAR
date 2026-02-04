import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/models.dart';
import '../blocs/blocs.dart';
import '../widgets/widgets.dart';

/// Main home screen with all portfolio sections
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {
    AppConstants.heroSection: GlobalKey(),
    AppConstants.aboutSection: GlobalKey(),
    AppConstants.skillsSection: GlobalKey(),
    AppConstants.experienceSection: GlobalKey(),
    AppConstants.projectsSection: GlobalKey(),
    AppConstants.educationSection: GlobalKey(),
    AppConstants.accomplishmentsSection: GlobalKey(),
    AppConstants.contactSection: GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    context.read<PortfolioBloc>().add(const LoadPortfolio());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: AppColors.heroGradient,
            ),
          ),
          // Particle background
          const Positioned.fill(
            child: ParticleBackground(particleCount: 60),
          ),
          // Content
          Column(
            children: [
              // Navigation bar
              NavBar(
                scrollController: _scrollController,
                sectionKeys: _sectionKeys,
              ),
              // Scrollable content
              Expanded(
                child: BlocBuilder<PortfolioBloc, PortfolioState>(
                  builder: (context, state) {
                    if (state is PortfolioLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.accentPurple,
                        ),
                      );
                    }
                    if (state is PortfolioLoaded) {
                      return _buildContent(state);
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent(PortfolioLoaded state) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppConstants.mobileBreakpoint;
    final isTablet = screenWidth >= AppConstants.mobileBreakpoint &&
        screenWidth < AppConstants.desktopBreakpoint;
    final isDesktop = screenWidth >= AppConstants.desktopBreakpoint;
    
    // Zig-Zag alignment for desktop
    final aboutAlignment = isDesktop ? Alignment.centerLeft : Alignment.center;


    final horizontalPadding = isMobile ? 20.0 : (isTablet ? 40.0 : 40.0);
    // Increased max width to fill more screen space as requested
    final maxWidth = 1800.0;

    return SingleChildScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const _HeroSection(),
                const SizedBox(height: 80),
                // About Section
                AnimatedSection(
                  key: _sectionKeys[AppConstants.aboutSection],
                  child: _AboutSection(alignment: aboutAlignment),
                ),
                const SizedBox(height: 80),
                // Skills Section
                AnimatedSection(
                   key: _sectionKeys[AppConstants.skillsSection],
                   child: _SkillsSection(
                     skills: Skill.allSkills,

                   ),
                ),
                const SizedBox(height: 80),
                // Experience Section
                AnimatedSection(
                  key: _sectionKeys[AppConstants.experienceSection],
                  child: _ExperienceSection(
                    experiences: Experience.allExperiences,

                  ),
                ),
                const SizedBox(height: 80),
                // Projects Section
                AnimatedSection(
                  key: _sectionKeys[AppConstants.projectsSection],
                  child: _ProjectsSection(

                    projects: Project.allProjects,
                  ),
                ),
                const SizedBox(height: 80),
                // Education Section
                AnimatedSection(
                  child: _EducationSection(
                    education: Education.education,

                  ),
                ),
                const SizedBox(height: 80),
                // Accomplishments Section
                AnimatedSection(
                  child: _AccomplishmentsSection(
                    accomplishments: Accomplishment.allAccomplishments,

                  ),
                ),
                const SizedBox(height: 80),
                // Contact Section
                AnimatedSection(
                  child: _ContactSection(
                      key: _sectionKeys[AppConstants.contactSection]),
                ),
                const SizedBox(height: 60),
                // Footer
                const _Footer(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ========================== HERO SECTION ==========================

class _HeroSection extends StatelessWidget {
  const _HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile =
        MediaQuery.of(context).size.width < AppConstants.mobileBreakpoint;

    return Container(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 60 : 100),
      child: Column(
        children: [
          // Greeting
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Hello, I am',
                textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.accentCyan,
                    ),
                speed: const Duration(milliseconds: 80),
              ),
            ],
            totalRepeatCount: 1,
          ),
          const SizedBox(height: 16),
          // Name
          GradientText(
            text: AppConstants.name,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: isMobile ? 48 : 72,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          // Title
          // Title
          SizedBox(
            height: 50, // Fixed height to prevent layout jump
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.bold,
                  ),
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Software Developer',
                    speed: const Duration(milliseconds: 100),
                  ),
                  TypewriterAnimatedText(
                    'Flutter Expert',
                    speed: const Duration(milliseconds: 100),
                  ),
                  TypewriterAnimatedText(
                    'Full Stack Engineer',
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                onTap: () {
                  // Interactable if needed
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Subtitle
          Text(
            AppConstants.subtitle,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textMuted,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          // Contact info
          Wrap(
            spacing: 24,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              _ContactChip(
                icon: Icons.location_on_outlined,
                label: AppConstants.location,
              ),
              _ContactChip(
                icon: Icons.phone_outlined,
                label: AppConstants.phone,
              ),
              _ContactChip(
                icon: Icons.email_outlined,
                label: AppConstants.email,
              ),
            ],
          ),
          const SizedBox(height: 48),
          // CTA Buttons
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              _GradientButton(
                label: 'Download Resume',
                icon: Icons.download,
                onTap: () => _launchUrl(AppConstants.resumeUrl),
              ),
              _OutlinedButton(
                label: 'Get In Touch',
                icon: Icons.arrow_forward,
                onTap: () => _launchUrl('mailto:${AppConstants.email}'),
              ),
            ],
          ),
          const SizedBox(height: 48),
          // Store buttons
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              _StoreButton(
                label: 'Play Store',
                icon: FontAwesomeIcons.googlePlay,
                url: AppConstants.playStoreUrl,
              ),
              _StoreButton(
                label: 'App Store',
                icon: FontAwesomeIcons.apple,
                url: AppConstants.appStoreUrl,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class _ContactChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ContactChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: AppColors.accentPurple),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _GradientButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _GradientButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<_GradientButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(12),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.accentPurple.withValues(alpha: 0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 20),
              const SizedBox(width: 12),
              Text(
                widget.label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OutlinedButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _OutlinedButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_OutlinedButton> createState() => _OutlinedButtonState();
}

class _OutlinedButtonState extends State<_OutlinedButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.accentPurple.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered ? AppColors.accentPurple : AppColors.glassBorder,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color:
                      _isHovered ? AppColors.accentPurple : AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 12),
              Icon(
                widget.icon,
                size: 20,
                color:
                    _isHovered ? AppColors.accentPurple : AppColors.textPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StoreButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final String url;

  const _StoreButton({
    required this.label,
    required this.icon,
    required this.url,
  });

  @override
  State<_StoreButton> createState() => _StoreButtonState();
}

class _StoreButtonState extends State<_StoreButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.glassWhite.withValues(alpha: 0.2)
                : AppColors.glassWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                widget.icon,
                size: 20,
                color: _isHovered ? AppColors.accentPurple : AppColors.textPrimary,
              ),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: _isHovered ? AppColors.accentPurple : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ========================== ABOUT SECTION ==========================

class _AboutSection extends StatelessWidget {
  final AlignmentGeometry alignment;

  const _AboutSection({super.key, this.alignment = Alignment.center});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= AppConstants.desktopBreakpoint;

    final aboutCard = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 800),
      child: GlassCard(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.person, size: 24),
                ),
                const SizedBox(width: 16),
                Text(
                  'Objective',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              AppConstants.objective,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.8,
                  ),
            ),
          ],
        ),
      ),
    );

    if (isDesktop) {
      return Column(
        children: [
          _SectionHeader(title: 'About Me'),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: aboutCard),
              const SizedBox(width: 40),
              Expanded(
                child: _CodeWindow(),
              ),
            ],
          ),
        ],
      );
    }

    return Column(
      children: [
        _SectionHeader(title: 'About Me'),
        const SizedBox(height: 32),
        Align(
          alignment: alignment,
          child: aboutCard,
        ),
      ],
    );
  }
}

class _CodeWindow extends StatelessWidget {
  const _CodeWindow();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 800),
      child: GlassCard(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(radius: 6, backgroundColor: Colors.redAccent),
                const SizedBox(width: 8),
                const CircleAvatar(radius: 6, backgroundColor: Colors.amber),
                const SizedBox(width: 8),
                const CircleAvatar(radius: 6, backgroundColor: Colors.greenAccent),
                const SizedBox(width: 16),
                Text(
                  'developer_profile.dart',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textMuted,
                        fontFamily: 'monospace',
                      ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              '''
class Developer {
  final String name = "${AppConstants.name}";
  final String role = "Flutter Enthusiast";
  
  List<String> get skills => [
    "Dart",
    "Flutter",
    "Clean Architecture",
    "Firebase",
    "Riverpod"
  ];

  void code() {
    print("Building utilizing pixels...");
  }
}
''',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'monospace',
                    height: 1.5,
                    color: AppColors.accentCyan,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

// ========================== SKILLS SECTION ==========================

class _SkillsSection extends StatelessWidget {
  final List<Skill> skills;

  const _SkillsSection({
    super.key,
    required this.skills,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= AppConstants.desktopBreakpoint;

    final skillsCard = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 800),
      child: GlassCard(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: skills.map((skill) {
                return SkillChip(
                   label: skill.name,
                   category: skill.category,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );

    if (isDesktop) {
      return Column(
        children: [
          _SectionHeader(title: 'Skills'),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: _PlaceholderFiller(
                  icon: FontAwesomeIcons.layerGroup,
                  title: 'Tech Stack',
                  subtitle: 'Modern & Scalable',
                  alignment: Alignment.centerRight,
                  color: Colors.amberAccent,
                ),
              ),
              const SizedBox(width: 40),
              Expanded(child: skillsCard),
            ],
          ),
        ],
      );
    }

    return Column(
      children: [
        _SectionHeader(title: 'Skills'),
        const SizedBox(height: 32),
        skillsCard,
      ],
    );
  }
}

// ========================== EXPERIENCE SECTION ==========================

class _ExperienceSection extends StatelessWidget {
  final List<Experience> experiences;

  const _ExperienceSection({
      super.key,
      required this.experiences,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= AppConstants.desktopBreakpoint;

    // Use a slightly wider constraint for experience content
    final experienceContent = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 800),
      child: Column(
          children: experiences.map((exp) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: _ExperienceCard(experience: exp),
            );
          }).toList(),
      ),
    );

    if (isDesktop) {
      return Column(
        children: [
          _SectionHeader(title: 'Experience'),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Expanded(child: experienceContent),
               const SizedBox(width: 40),
               Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: _PlaceholderFiller(
                    icon: FontAwesomeIcons.briefcase,
                    title: 'Professional Journey',
                    subtitle: '${experiences.length}+ Years Experience',
                    alignment: Alignment.centerLeft,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Column(
      children: [
        _SectionHeader(title: 'Experience'),
        const SizedBox(height: 32),
        experienceContent,
      ],
    );
  }
}

// ========================== PROJECTS SECTION ==========================

class _ProjectsSection extends StatelessWidget {
  final List<Project> projects;

  const _ProjectsSection({
    super.key,
    required this.projects,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppConstants.mobileBreakpoint;
    final isTablet = screenWidth >= AppConstants.mobileBreakpoint &&
        screenWidth < AppConstants.desktopBreakpoint;
    
    // 4 columns on large desktop, 3 on standard desktop, 2 on tablet, 1 on mobile
    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : (screenWidth > 1400 ? 4 : 3));
    // Wider aspect ratio for shorter cards
    final aspectRatio = isMobile ? 1.4 : (isTablet ? 1.3 : 1.3);

    return Column(
      children: [
        _SectionHeader(title: 'Projects'),
        const SizedBox(height: 8),
        Text(
          '${projects.length} Projects • Production & Beyond',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textMuted,
              ),
        ),
        const SizedBox(height: 32),
        AnimationLimiter(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: aspectRatio,
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: crossAxisCount,
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: ProjectCard(project: projects[index]),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ========================== EDUCATION SECTION ==========================

class _EducationSection extends StatelessWidget {
  final Education education;

  const _EducationSection({
    super.key,
    required this.education,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= AppConstants.desktopBreakpoint;

    final educationCard = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 800),
      child: GlassCard(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: AppColors.secondaryGradient,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.school, size: 32),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    education.degree,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    education.institution,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.accentCyan,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    education.year,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textMuted,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    if (isDesktop) {
      return Column(
        children: [
          _SectionHeader(title: 'Education'),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: _PlaceholderFiller(
                  icon: FontAwesomeIcons.graduationCap,
                  title: 'Academic Background',
                  subtitle: 'Foundation of Knowledge',
                  alignment: Alignment.centerRight,
                  color: Colors.purpleAccent,
                ),
              ),
              const SizedBox(width: 40),
              Expanded(child: educationCard),
            ],
          ),
        ],
      );
    }

    return Column(
      children: [
        _SectionHeader(title: 'Education'),
        const SizedBox(height: 32),
        educationCard,
      ],
    );
  }
}

// ========================== ACCOMPLISHMENTS SECTION ==========================

class _AccomplishmentsSection extends StatelessWidget {
  final List<Accomplishment> accomplishments;

  const _AccomplishmentsSection({
    super.key,
    required this.accomplishments,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= AppConstants.desktopBreakpoint;

    // Accomplishments Content
    Widget accomplishmentsContent;
    if (isDesktop) {
        // Use column for desktop side-by-side content to stack them nicely
        accomplishmentsContent = Column(
          children: accomplishments.asMap().entries.map((entry) {
             final index = entry.key;
             final accomplishment = entry.value;
             return Padding(
               padding: const EdgeInsets.only(bottom: 20),
               child: _AccomplishmentCard(accomplishment: accomplishment, index: index),
             );
          }).toList(),
        );
    } else {
       accomplishmentsContent = Column(
         children: accomplishments.asMap().entries.map((entry) {
            final index = entry.key;
            final accomplishment = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _AccomplishmentCard(accomplishment: accomplishment, index: index),
            );
         }).toList(),
       );
    }

    if (isDesktop) {
      return Column(
        children: [
          _SectionHeader(title: 'Accomplishments'),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: accomplishmentsContent,
              ),
              const SizedBox(width: 40),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24),
                   child: _PlaceholderFiller(
                    icon: FontAwesomeIcons.trophy,
                    title: 'Achievements',
                    subtitle: 'Milestones & Awards',
                    alignment: Alignment.centerLeft,
                    color: Colors.orangeAccent,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Column(
      children: [
        _SectionHeader(title: 'Accomplishments'),
        const SizedBox(height: 32),
        accomplishmentsContent,
      ],
    );
  }
}

class _PlaceholderFiller extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Alignment alignment;
  final Color color;

  const _PlaceholderFiller({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.alignment,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Opacity(
          opacity: 0.8,
          child: GlassCard(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 64, color: color.withOpacity(0.8)),
                const SizedBox(height: 24),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textMuted,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                // Decorative dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) => 
                     Container(
                       margin: const EdgeInsets.symmetric(horizontal: 4),
                       width: 8,
                       height: 8,
                       decoration: BoxDecoration(
                         color: color.withOpacity(0.5),
                         shape: BoxShape.circle,
                       ),
                     )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  final Experience experience;

  const _ExperienceCard({required this.experience});

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: _isHovered ? (Matrix4.identity()..translate(0.0, -4.0)) : Matrix4.identity(),
            child: GlassCard(
                padding: const EdgeInsets.all(24),
                backgroundColor: _isHovered 
                    ? AppColors.glassWhite.withValues(alpha: 0.15) 
                    : AppColors.glassWhite,
                child: IntrinsicHeight(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                            // Date Column (Left)
                            Container(
                                width: 140,
                                padding: const EdgeInsets.only(right: 16),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                            color: AppColors.glassBorder,
                                            width: 1,
                                        ),
                                    ),
                                ),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        Text(
                                            widget.experience.duration.split(' - ')[0],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: AppColors.accentCyan,
                                            ),
                                            textAlign: TextAlign.right,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                            'to',
                                            style: Theme.of(context).textTheme.bodySmall,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                            widget.experience.duration.split(' - ')[1],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: AppColors.accentPurple,
                                            ),
                                            textAlign: TextAlign.right,
                                        ),
                                    ],
                                ),
                            ),
                            // Content Column (Right)
                            Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 24),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                    Expanded(
                                                        child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                                Text(
                                                                    widget.experience.title,
                                                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                                                        fontWeight: FontWeight.bold,
                                                                    ),
                                                                ),
                                                                const SizedBox(height: 4),
                                                                Text(
                                                                    widget.experience.company,
                                                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                                        color: AppColors.textSecondary,
                                                                    ),
                                                                ),
                                                            ],
                                                        ),
                                                    ),
                                                    if (widget.experience.location.isNotEmpty)
                                                        Container(
                                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                                            decoration: BoxDecoration(
                                                                color: AppColors.primaryLight,
                                                                borderRadius: BorderRadius.circular(8),
                                                            ),
                                                            child: Row(
                                                                children: [
                                                                    const Icon(Icons.location_on, size: 12, color: AppColors.textMuted),
                                                                    const SizedBox(width: 4),
                                                                    Text(
                                                                        widget.experience.location,
                                                                        style: Theme.of(context).textTheme.bodySmall,
                                                                    ),
                                                                ],
                                                            ),
                                                        ),
                                                ],
                                            ),
                                            const SizedBox(height: 16),
                                            ...widget.experience.responsibilities.map((r) => Padding(
                                                padding: const EdgeInsets.only(bottom: 8),
                                                child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                        const Padding(
                                                            padding: EdgeInsets.only(top: 6, right: 8),
                                                            child: Icon(Icons.circle, size: 6, color: AppColors.accentPurple),
                                                        ),
                                                        Expanded(child: Text(r, style: Theme.of(context).textTheme.bodyMedium)),
                                                    ],
                                                ),
                                            )),
                                        ],
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        ),
    );
  }
}


class _AccomplishmentCard extends StatelessWidget {
  final Accomplishment accomplishment;
  final int index;

  const _AccomplishmentCard({
    required this.accomplishment,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: index == 0
                  ? AppColors.primaryGradient
                  : AppColors.secondaryGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              index == 0 ? Icons.psychology : Icons.auto_awesome,
              size: 24,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  accomplishment.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  accomplishment.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ========================== CONTACT SECTION ==========================

class _ContactSection extends StatelessWidget {
  const _ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile =
        MediaQuery.of(context).size.width < AppConstants.mobileBreakpoint;

    return Column(
      children: [
        _SectionHeader(title: 'Get In Touch'),
        const SizedBox(height: 16),
        Text(
          'I\'m always open to discussing new projects and opportunities.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        GlassCard(
          padding: const EdgeInsets.all(32),
          child: Wrap(
            spacing: isMobile ? 20 : 48,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: [
              _ContactItem(
                icon: Icons.email_outlined,
                label: 'Email',
                value: AppConstants.email,
                onTap: () => _launchUrl('mailto:${AppConstants.email}'),
              ),
              _ContactItem(
                icon: Icons.phone_outlined,
                label: 'Phone',
                value: AppConstants.phone,
                onTap: () => _launchUrl('tel:${AppConstants.phone}'),
              ),
              _ContactItem(
                icon: Icons.location_on_outlined,
                label: 'Location',
                value: AppConstants.location,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class _ContactItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _ContactItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  State<_ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<_ContactItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.accentPurple.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: _isHovered ? AppColors.primaryGradient : null,
                  color: _isHovered ? null : AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  widget.icon,
                  size: 28,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.label,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 4),
              Text(
                widget.value,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: _isHovered
                          ? AppColors.accentPurple
                          : AppColors.textPrimary,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ========================== FOOTER ==========================

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(color: AppColors.glassBorder),
        const SizedBox(height: 24),
        Text(
          '© 2024 Vijay Arther. All rights reserved.',
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Built with Flutter 💙',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.accentCyan,
              ),
        ),
      ],
    );
  }
}

// ========================== SHARED COMPONENTS ==========================

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GradientText(
          text: title,
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}
