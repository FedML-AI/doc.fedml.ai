import { Icon } from '@iconify/react';
import React from 'react';

export type Product = {
  title: string;
  link: string;
  beta?: boolean;
  icon: () => React.JSX.Element;
  lightImage: string;
  darkImage: string;
  text: (() => React.JSX.Element) | string | React.JSX.Element;
};

export const LAUNCH_PRODUCT: Product[] = [
  {
    title:
      'ChainOpera®Launch: Run Any Job on GPU Marketplace or On-Premise Cluster',
    link: '/launch',
    icon: () => <Icon icon="bi:gpu-card" />,
    lightImage: '/img/landing-page/hero/video-graphic.png',
    darkImage: '/img/landing-page/hero/video-graphic-dark.png',
    text: (
      <>
        <b>
          <pre className="prism-code py-1">
            <b className="text-primary">fedml</b> launch job.yaml
          </pre>
        </b>
        <ul>
          <li>
            1-line CLI as a quick launcher for running any AI job on any public
            and/or decentralized GPU cloud
          </li>
          <li>Offering lower prices, higher GPU availability</li>
          <li>
            Support ChainOpera® Train, ChainOpera® Serve, ChainOpera®
            Federate
          </li>
        </ul>
      </>
    ),
  },
];

export const MLOPS_PRODUCTS: Product[] = [
  {
    title: 'ChainOpera AI',
    beta: true,
    link: '/platform',
    icon: () => <Icon icon="carbon:ibm-watson-studio" />,
    lightImage: '/img/landing-page/hero/video-graphic.png',
    darkImage: '/img/landing-page/hero/video-graphic-dark.png',
    text: 'The dedicated cloud platform for next-gen AI/ML development and operations',
  },
  {
    title: 'ChainOpera® Open Source',
    beta: true,
    link: '/open-source',
    icon: () => <Icon icon="carbon:ibm-watson-studio" />,
    lightImage: '/img/landing-page/hero/video-graphic.png',
    darkImage: '/img/landing-page/hero/video-graphic-dark.png',
    text: 'The unified and scalable machine learning library for large-scale distributed training, model serving, and federated learning',
  },
];

export const COMPUTE_FRAMEWORK: Product[] = [
  {
    title: 'Train',
    link: '/train',
    icon: () => <Icon icon="carbon:machine-learning-model" />,
    lightImage: '/img/landing-page/hero/video-graphic.png',
    darkImage: '/img/landing-page/hero/video-graphic-dark.png',
    text: (
      <>
        <b>Large-scale distributed training </b>
        <ul>
          <li>Large & foundational models</li>
          <li>Fast and efficient</li>
          <li>Scalable to any cluster</li>
        </ul>
      </>
    ),
  },
  {
    title: 'Deploy',
    link: '/deploy',
    icon: () => <Icon icon="codicon:server-process" />,
    lightImage: '/img/landing-page/hero/video-graphic.png',
    darkImage: '/img/landing-page/hero/video-graphic-dark.png',
    text: (
      <>
        <b>Model serving framework</b>
        <ul>
          <li>Scalability </li>
          <li>Low latency Low cost </li>
          <li>Observability & Refinement </li>
        </ul>
      </>
    ),
    // text: '- ChainOpera® Serve is a model serving platform for high scalability and low latency.',
  },
  {
    title: 'Federate',
    link: '/federate',
    icon: () => <Icon icon="lucide:combine" />,
    lightImage: '/img/landing-page/hero/video-graphic.png',
    darkImage: '/img/landing-page/hero/video-graphic-dark.png',
    text: (
      <>
        <b>Federated Learning framework </b>
        <ul>
          <li>Top open-source library</li>
          <li>training across edge nodes, smartphone, & cloud</li>
          <li>Maximum privacy & personalization</li>
        </ul>
      </>
    ),
  },
];

export const IaaS: Product[] = [
  {
    title: 'ChainOpera®Launch: Distributed GPU Cloud',
    // TODO: Supplement with the correct documentation links
    link: '/platform/todo',
    icon: () => <Icon icon="bi:gpu-card" />,
    lightImage: '/img/landing-page/hero/video-graphic.png',
    darkImage: '/img/landing-page/hero/video-graphic-dark.png',
    text: (
      <>
        <b>
          <pre className="prism-code py-1">
            <b className="text-primary">fedml</b> launch job.yaml
          </pre>
        </b>
        <ul>
          <li>
            1-line CLI as a quick launcher for running any AI job on any public
            and/or decentralized GPU cloud
          </li>
          <li>Offering lower prices, higher GPU availability</li>
          <li>
            Support ChainOpera® Train, ChainOpera® Serve, ChainOpera®
            Federate
          </li>
        </ul>
      </>
    ),
  },
];
