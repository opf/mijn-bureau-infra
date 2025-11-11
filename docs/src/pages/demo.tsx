import type { ReactNode } from "react";
import clsx from "clsx";
import Link from "@docusaurus/Link";
import useDocusaurusContext from "@docusaurus/useDocusaurusContext";
import Layout from "@theme/Layout";
import Heading from "@theme/Heading";

function DemoHero(): ReactNode {
  return (
    <header className={clsx("hero hero--primary")}>
      <div className="container">
        <Heading as="h1" className="hero__title">
          Experience MijnBureau Live
        </Heading>
        <p className="hero__subtitle">
          See how our secure, autonomous digital workplace can transform your
          organization
        </p>
        <div className={clsx("margin-top--lg")}>
          <Link
            className="button button--secondary button--lg margin-right--md"
            href="mailto:opensource@MinBZK.nl?subject=MijnBureau Demo&body=Hoi,%0D%0A%0D%0AGraag zou ik een demo willen voor mijn organizatie.%0D%0A%0D%0AWanneer hebben jullie tijd.%0D%0A%0D%0ABedankt!"
          >
            📧 Book a Demo
          </Link>
          <Link
            className="button button--outline button--secondary button--lg"
            href="mailto:opensource@MinBZK.nl?subject=MijnBureau Demo omgeving&body=Hoi,%0D%0A%0D%0AGraag zou ik een demo omgeving willen voor mijn organisatie.%0D%0A%0D%0AKunnen we hier binnekort over praten.%0D%0A%0D%0ABedankt!"
          >
            📖 Request a dedicated deployment
          </Link>
        </div>
      </div>
    </header>
  );
}

function DemoSection(): ReactNode {
  return (
    <section className={clsx("padding-vert--xl")}>
      <div className="container">
        <div className="row">
          <div className="col col--8 col--offset-2">
            <div className="text--center margin-bottom--lg">
              <Heading as="h2">Why Request a Demo?</Heading>
              <p className="margin-bottom--lg">
                See firsthand how MijnBureau can provide your organization with
                a secure, sovereign digital workplace that meets government
                requirements.
              </p>
            </div>

            <div className="row margin-bottom--xl">
              <div className="col col--6">
                <div className="card">
                  <div className="card__header">
                    <h3>🔒 Security First</h3>
                  </div>
                  <div className="card__body">
                    <p>
                      Experience our secure architecture and see how MijnBureau
                      protects your sensitive data with enterprise-grade
                      security.
                    </p>
                  </div>
                </div>
              </div>
              <div className="col col--6">
                <div className="card">
                  <div className="card__header">
                    <h3>🏛️ Government Ready</h3>
                  </div>
                  <div className="card__body">
                    <p>
                      Discover how our platform meets governmental requirements
                      and supports digital autonomie for public sector
                      organizations.
                    </p>
                  </div>
                </div>
              </div>
            </div>

            <div className="row margin-bottom--xl">
              <div className="col col--6">
                <div className="card">
                  <div className="card__header">
                    <h3>⚙️ Full Autonomy</h3>
                  </div>
                  <div className="card__body">
                    <p>
                      See how you can run everything on your own infrastructure
                      while maintaining complete control over your data.
                    </p>
                  </div>
                </div>
              </div>
              <div className="col col--6">
                <div className="card">
                  <div className="card__header">
                    <h3>🔧 Easy Integration</h3>
                  </div>
                  <div className="card__body">
                    <p>
                      Learn how MijnBureau integrates with your existing systems
                      and workflows without disruption.
                    </p>
                  </div>
                </div>
              </div>
            </div>

            <div className="text--center">
              <div className="margin-bottom--md">
                <Heading as="h3">Ready to Get Started?</Heading>
                <p>
                  Contact our team to schedule a personalized demonstration of
                  MijnBureau. We'll show you how our platform can meet your
                  organization's specific needs.
                </p>
              </div>

              <div className="margin-bottom--lg">
                <Link
                  className="button button--primary button--lg"
                  href="mailto:opensource@MinBZK.nl?subject=MijnBureau Demo&body=Hoi,%0D%0A%0D%0AGraag zou ik een demo willen voor mijn organizatie.%0D%0A%0D%0AWanneer hebben jullie tijd.%0D%0A%0D%0ABedankt!"
                >
                  📧 Contact Us: opensource@MinBZK.nl
                </Link>
              </div>

              <p>
                <small>
                  We typically respond within 3 days and can accommodate demos
                  in Dutch or English.
                </small>
              </p>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}

export default function Demo(): ReactNode {
  const { siteConfig } = useDocusaurusContext();
  return (
    <Layout
      title={`Demo - ${siteConfig.title}`}
      description="Book a demo of MijnBureau - the flexible and secure digital workplace suite for government organizations"
    >
      <DemoHero />
      <main>
        <DemoSection />
      </main>
    </Layout>
  );
}
