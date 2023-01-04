module.exports = {
  theme: 'cosmos',
  title: 'Mara Documentation',
  themeConfig: {
    logo: {
      src: '/logo.svg',
    },
    topbar: {
      banner: false,
    },
    custom: true,
    sidebar: {
      auto: false,
      nav: [
        {
          title: 'About Mara',
          children: [
            {
              title: 'Introduction',
              directory: true,
              path: '/intro',
            },
          ],
        },
        {
          title: 'For Validators',
          children: [
            {
              title: 'Overview',
              directory: false,
              path: '/validators/overview',
            },
            {
              title: 'Installation',
              directory: true,
              path: '/validators/installation',
            },
            {
              title: 'Setup & Configuration',
              directory: true,
              path: '/validators/setup',
            },
            {
              title: 'Join Testnet',
              directory: false,
              path: '/validators/join-testnet',
            },
            {
              title: 'Join Mainnet',
              directory: false,
              path: '/validators/join-mainnet',
            },
            {
              title: 'Security',
              directory: true,
              path: '/validators/security',
            },
            {
              title: 'Software Upgrades',
              directory: true,
              path: '/validators/software-upgrades',
            },
            {
              title: 'Frequently Asked Questions',
              directory: false,
              path: '/validators/faq',
            },
          ],
        },
      ],
    },
  },
}
