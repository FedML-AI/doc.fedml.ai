import React from 'react';
import Head from '@docusaurus/Head';
import Layout from '@theme/Layout';
// import FeatureSection from '@site/src/components/homepage/FeatureSection';
import HeroSection from '@site/src/components/homepage/HeroSection';
// import ProductColSection from '@site/src/components/homepage/ProductColSection';
import ProductLayerSection from '../components/homepage/ProductLayerSection';

export default function Home() {
  return (
    <Layout>
      <Head>
        <link rel="prefetch" href="/assets/css/elements.min.css" />
      </Head>

      <HeroSection />

      {/* <FeatureSection /> */}

      <main className="noise-bg mt-4">
        <ProductLayerSection />

        {/* <ProductColSection /> */}
      </main>
    </Layout>
  );
}
