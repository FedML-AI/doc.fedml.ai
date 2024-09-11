import React from 'react';
import { COMPUTE_FRAMEWORK, IaaS, MLOPS_PRODUCTS } from './Product.config';
import { ProductCardItem } from './ProductItem';

export default function HeroSection() {
  return (
    <>
      <section className="mx-auto max-w-5xl mb-10">
        <h3 className="px-4">MLOPS</h3>
        <div className="grid w-full grid-cols-1 gap-6 px-4 md:grid-cols-2">
          {MLOPS_PRODUCTS.map((product, i) => (
            <ProductCardItem {...product} key={product.title} />
          ))}
        </div>
      </section>

      <section className="mx-auto max-w-5xl mb-10">
        <h3 className="px-4">
          ChainOpera® Unified and Scalable Machine Learning Library
        </h3>
        <div className="grid w-full grid-cols-1 gap-6 px-4 md:grid-cols-2">
          {COMPUTE_FRAMEWORK.map((product, i) => (
            <ProductCardItem {...product} key={product.title} />
          ))}
        </div>
      </section>

      <section className="mx-auto max-w-5xl mb-10">
        <h3 className="px-4">IaaS (GPU as a Service)</h3>
        <div className="grid w-full grid-cols-1 gap-6 px-4 md:grid-cols-2">
          {IaaS.map((product, i) => (
            <ProductCardItem {...product} key={product.title} />
          ))}
        </div>
      </section>
    </>
  );
}
