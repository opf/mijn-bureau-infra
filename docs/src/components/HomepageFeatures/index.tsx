import type { ReactNode } from "react";
import clsx from "clsx";
import Heading from "@theme/Heading";
import styles from "./styles.module.css";

type FeatureItem = {
  title: string;
  Svg: React.ComponentType<React.ComponentProps<"svg">>;
  description: ReactNode;
};

const FeatureList: FeatureItem[] = [
  {
    title: "Autonomy",
    Svg: require("@site/static/img/code-bracket-square.svg").default,
    description: (
      <>
        Run everything on your own hardware and maintain full control over your
        critical data.
      </>
    ),
  },
  {
    title: "Secure",
    Svg: require("@site/static/img/cloud.svg").default,
    description: <>Built securely from the ground up.</>,
  },
  {
    title: "Government Ready",
    Svg: require("@site/static/img/shield-check.svg").default,
    description: <>Designed to meet government requirements.</>,
  },
];

function Feature({ title, Svg, description }: FeatureItem) {
  return (
    <div className={clsx("col col--4")}>
      <div className="text--center">
        <Svg className={styles.featureSvg} role="img" />
      </div>
      <div className="text--center padding-horiz--md">
        <Heading as="h3">{title}</Heading>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures(): ReactNode {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
