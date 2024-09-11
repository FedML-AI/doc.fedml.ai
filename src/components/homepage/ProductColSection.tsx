import clsx from 'clsx';
import React from 'react';
import { COMPUTE_FRAMEWORK, IaaS, MLOPS_PRODUCTS } from './Product.config';
import { ProductLinkItem } from './ProductItem';

export default function ProductColSection() {
  return (
    <section
      className={clsx(
        'my-40 mx-auto p-4 py-0',
        'no-underline-links flex w-full max-w-7xl flex-col gap-10 md:flex-row md:gap-0',
      )}
    >
      <div className="flex-1">
        <div className="mb-4 flex items-center justify-between">
          <h3 className="m-0">MLOPS</h3>

          {/* <Link to="/guides" className="font-jakarta text-sm font-semibold">
            View more guides <ArrowRightFilled className="ml-1" />
          </Link> */}
        </div>

        <div className="flex flex-col gap-4">
          {MLOPS_PRODUCTS.map((guide) => (
            <ProductLinkItem {...guide} key={guide.title} />
          ))}
        </div>
      </div>

      <div
        className={clsx(
          'mx-8 block flex-shrink-0 bg-gradient-to-b from-transparent via-secondary-700 to-transparent',
          'hidden w-px md:block',
        )}
      />

      <div className="flex-1">
        <div className="mb-4 flex items-center justify-between">
          <h3 className="m-0">
            ChainOpera® Unified and Scalable Machine Learning Library
          </h3>
        </div>

        <div className="flex flex-col gap-4">
          {COMPUTE_FRAMEWORK.map((guide) => (
            <ProductLinkItem {...guide} key={guide.title} />
          ))}
        </div>
      </div>

      <div
        className={clsx(
          'mx-8 block flex-shrink-0 bg-gradient-to-b from-transparent via-secondary-700 to-transparent',
          'hidden w-px md:block',
        )}
      />

      <div className="flex-1">
        <div className="mb-4 flex items-center justify-between">
          <h3 className="m-0">IaaS</h3>
        </div>

        <div className="flex flex-col gap-4">
          {IaaS.map((guide) => (
            <ProductLinkItem {...guide} key={guide.title} />
          ))}
        </div>
      </div>
    </section>
  );
}
