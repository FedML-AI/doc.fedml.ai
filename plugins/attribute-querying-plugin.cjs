// Support for ?docusaurus-data-mode=embed&docusaurus-attribute-myAttr=42
const DataQueryStringPrefixKey = 'docusaurus-data-';

/* language=js */
const DataAttributeQueryStringInlineJavaScript = `
(function() {
  try {
    const entries = new URLSearchParams(window.location.search).entries();
    for (var [searchKey, value] of entries) {
      if (searchKey.startsWith('${DataQueryStringPrefixKey}')) {
        var key = searchKey.replace('${DataQueryStringPrefixKey}',"data-")
        document.documentElement.setAttribute(key, value);
      }
    }
  } catch(e) {}
})();
`;

/**
 * @type {import('@docusaurus/types').PluginModule}
 */
const attributeQueryingPlugin = () => {
  return {
    name: 'attribute-querying-plugin',
    injectHtmlTags: () => {
      return {
        headTags: [
          {
            tagName: 'script',
            innerHTML: `${DataAttributeQueryStringInlineJavaScript}`,
          },
        ],
      };
    },
  };
};

module.exports = {
  attributeQueryingPlugin,
};
