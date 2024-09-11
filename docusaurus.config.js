const {
  attributeQueryingPlugin,
} = require('./plugins/attribute-querying-plugin.cjs');
const { webpackPlugin } = require('./plugins/webpack-plugin.cjs');
const tailwindPlugin = require('./plugins/tailwind-plugin.cjs');
// const compressPlugin = require('./plugins/compress-images-plugin.cjs');
const { defaultSettings } = require('./plugins/doc-plugin.cjs');

const code_themes = {
  light: require('prism-react-renderer/themes/github'),
  dark: require('prism-react-renderer/themes/vsDark'),
};

const meta = (() => {
  /** @type {import('@docusaurus/types').Config} */
  const metaBase = {
    title: 'ChainOpera® Documentation',
    // tagline: 'ChainOpera® AI Platform',
    url: 'https://docs.chainopera.ai',
    baseUrl: '/',
    favicon: 'img/favicon_co.ico',
    onBrokenLinks: 'throw',
    onBrokenMarkdownLinks: 'warn',
    i18n: {
      defaultLocale: 'en',
      locales: ['en'],
    },
  }

  return metaBase;
})();

const resources = [
  {
    label: 'Blog',
    href: 'https://blog.chainopera.ai',
  },
];

const resourceMapper = Object.fromEntries(
  resources.map((resource) => [resource.label, resource]),
);

const plugins = [
  attributeQueryingPlugin,
  tailwindPlugin,
  // ...docs_plugins,
  webpackPlugin,
  // compressPlugin,
  // TODO: set some redirects rules
  [
    '@docusaurus/plugin-client-redirects',
    {
      redirects: [
        {
          to: '/federate/cross-silo/user_guide',
          from: '/mlops/user_guide',
        },
      ],
      // createRedirects(path) {
      // @example return path list
      // if (path.startsWith("/guides/capabilities/webhooks")) {
      //   return [
      //     path.replace("/guides/capabilities/webhooks", "/guides/webhooks"),
      //     path.replace(
      //       "/guides/capabilities/webhooks",
      //       "/guides/features/webhooks"
      //     ),
      //   ];
      // }
      // return undefined; // Return a falsy value: no redirect created
      // },
    },
  ],
];

/** @type {import('@docusaurus/types').Config} */
const config = {
  ...meta,
  plugins,
  trailingSlash: false,
  themes: ['@docusaurus/theme-live-codeblock'],
  presets: [
    [
      '@docusaurus/preset-classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          ...defaultSettings,
          routeBasePath: '/',
          sidebarCollapsible: true,
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl: 'https://github.com/FedML-AI/docs.fedml.ai/tree/main/',
        },
        theme: {
          customCss: require.resolve('./src/css/custom.css'),
        },
        // googleTagManager: {
        //   containerId: "GTM-XXXXX",
        // },
      }),
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      image: 'img/logo_co.png',
      colorMode: {
        defaultMode: 'light',
      },
      docs: {
        sidebar: {
          hideable: true,
        },
      },
      metadata: [
        {
          name: 'description',
          content: 'Comprehensive documentation guide for ChainOpera. Covers Model Deployment, Serving, Training, Fine-tuning, Federate for efficient AI workflows.',
        },
        {
          name: 'og:description',
          content: 'Comprehensive documentation guide for ChainOpera. Covers Model Deployment, Serving, Training, Fine-tuning, Federate for efficient AI workflows.'
        }
      ],
      navbar: {
        title: 'ChainOpera AI Docs',
        logo: {
          href: '/',
          src: 'img/logo_co.png',
          // TODO: design a icon for dark mode.
          // srcDark: 'img/logo-dark.png',
          alt: 'ChainOpera AI Docs',
          height: '40px',
          // width: '40px',
        },
        items: [
          {
            type: 'docSidebar',
            sidebarId: 'platform',
            position: 'left',
            label: 'Platform',
          },
          {
            type: 'docSidebar',
            sidebarId: 'opensource',
            position: 'left',
            label: 'Open Source',
          },
          {
            type: 'docSidebar',
            sidebarId: 'deploy',
            position: 'left',
            label: 'Deploy',
          },
          {
            type: 'docSidebar',
            sidebarId: 'launch',
            position: 'left',
            label: 'Launch',
          },
          {
            type: 'docSidebar',
            sidebarId: 'train',
            position: 'left',
            label: 'Train',
          },
          {
            type: 'docSidebar',
            sidebarId: 'federate',
            position: 'left',
            label: 'Federate',
          },
          {
            type: 'docSidebar',
            sidebarId: 'storage',
            position: 'left',
            label: 'Storage',
          },
          {
            type: "docSidebar",
            sidebarId: "shareAndEarn",
            position: "left",
            label: "Share & Earn"
          },          
          // {
          //   label: "Resources",
          //   type: "dropdown",
          //   items: [...resources],
          //   position: "left",
          // },
          {
            label: 'Blog',
            href: 'https://blog.ChainOpera.ai',
            position: 'left',
          },
          {
            label: 'ChainOpera AI Home',
            href: 'https://ChainOpera.ai',
            position: 'left',
          },
          {
            label: 'FEDML Home',
            href: 'https://fedml.ai',
            position: 'left',
          },
          // {
          //   label: 'GitHub',
          //   href: 'https://github.com/FedML-AI/FedML',
          //   position: 'right',
          // },
          // {
          //   type: 'search',
          //   position: 'right',
          // },
          {
            label: 'Login',
            href: 'https://ChainOpera.ai',
            position: 'right',
            className: 'dev-portal-signup dev-portal-link',
          },
        ],
      },
      footer: {
        logo: {
          href: '/',
          src: '/img/logo_co.png',
          // TODO:
          // srcDark: '/img/logo-dark.png',
          alt: 'ChainOpera AI Docs',
          width: '40px',
          height: '40px',
        },
        links: [
          // {
          //   title: 'Product',
          //   items: [
          //     {
          //       label: 'Demo',
          //       href: 'https://ChainOpera.ai',
          //     },
          //     {
          //       label: 'Developer Portal',
          //       href: 'https://ChainOpera.ai',
          //     },
          //   ],
          // },
          {
            // title: 'Company',
            items: [
              // {
              //   label: 'About Us',
              //   href: 'https://ChainOpera.ai',
              // },
              // {
              //   label: 'Join Us',
              //   href: 'https://ChainOpera.ai',
              // },
              // {
              //   label: 'Privacy Policy',
              //   href: 'https://ChainOpera.ai',
              // },
              // {
              //   label: 'Contact Us',
              //   href: 'https://ChainOpera.ai',
              // },
            ],
          },
          // {
          //   title: 'Resources',
          //   items: [...resources],
          // },
        ],
        copyright: 'Copyright © ChainOpera since 2022. All rights reserved.',
      },
      prism: {
        theme: code_themes.light,
        darkTheme: code_themes.dark,
        additionalLanguages: [
          'dart',
          'ruby',
          'groovy',
          'kotlin',
          'java',
          'swift',
          'objectivec',
        ],
        magicComments: [
          {
            className: 'theme-code-block-highlighted-line',
            line: 'highlight-next-line',
            block: { start: 'highlight-start', end: 'highlight-end' },
          },
          {
            className: 'code-block-error-line',
            line: 'highlight-next-line-error',
          },
        ],
      },
      // support algolia for high level document query
      // algolia: {
      //   appId: 'AFINDOYCE8',
      //   apiKey: 'dbc6b095cadb32b759ac54fd671cb104',
      //   indexName: 'fedml',
      // },
    }),

  webpack: {
    jsLoader: (isServer) => ({
      loader: require.resolve('swc-loader'),
      options: {
        jsc: {
          parser: {
            syntax: 'typescript',
            tsx: true,
          },
          target: 'es2017',
        },
        module: {
          type: isServer ? 'commonjs' : 'es6',
        },
      },
    }),
  },
};

module.exports = config;
