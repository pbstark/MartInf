% KMart as a Bayesian audit
% Damjan Vukcevic
% 25 Jun 2019

This note shows a proof that KMart (the martingale approach described in this
repository) is equivalent to a Bayesian audit with a risk-maximising uniform
prior for the reported winner's true vote tally.  It also introduces a more
general version of the test statistic that corresponds to an arbitrary
risk-maximising prior.  Both results are shown for the case of sampling with
replacement, for a simple 2-candidate election.


# KMart is equivalent to a Bayesian audit

Suppose we are auditing a simple 2-candidate election, using sampling with
replacement.  We observe iid $X_1, X_2, \ldots \in \{0,1\}$, where $X_j = 1$ is
a vote for the reported winner and $X_j = 0$ is a vote for the reported loser.
Let $\mathbb{E} X_j = t$, the true tally of the reported winner.  In other
words, the $X_j$ are a sequence of Bernoulli trials with success probability
$t$.

The null hypothesis for the audit is that the reported winner actually lost,
i.e. that $t \leqslant \frac{1}{2}$.  To carry out a test, we usually set this
to the 'hardest' case^['Hardest' means that it is the case that leads to the
largest false positive rate (miscertification probability), i.e. the *risk*.],
which is $H_0\colon t = t_0 = \frac{1}{2}$.  The alternative hypothesis is that
the winning candidate was reported correctly, i.e. $H_1\colon t > \frac{1}{2}$.

In practice we will always have a finite number of total votes, and thus
a realistic model would have the support of $t$ be a discrete set (i.e. values
of the form $k / N$ where $N$ is the total number of votes).  However, for
mathematical convenience here we will allow the support of $t$ to be the unit
interval, which is continuous.


## KMart audits

KMart is a risk-limiting election auditing method based on martingale
theory.  For the context described above, it uses the following test statistic:
$$
A_n = \int_0^1 \prod_{j=1}^n \left(\gamma \left[\frac{X_j}{t_0} - 1\right]
    + 1\right) d\gamma.
$$
Since we are working with $t_0 = \frac{1}{2}$, we can rewrite this expression,
$$
A_n = 2^n \int_0^1 \prod_{j=1}^n \left(\gamma \left[X_j - \frac{1}{2}\right]
    + \frac{1}{2}\right) d\gamma.
$$
For a specified risk limit, $\alpha$, the audit proceeds until $A_n
> 1 / \alpha$, at which point the election is certified ($H_0$ is rejected), or
is otherwise terminated in favour of doing a full recount.


## Bayesian audits

A Bayesian audit is based on standard Bayesian inference.  The verdict of the
audit is based on the posterior probability that the reported winner actually
won (or lost, in which case this is called the *upset probability*). Typically,
a threshold will be placed on this probability for deciding whether to certify
the election or carry on sampling.^[A Bayesian audit requires specifying
a prior on the winner's vote tally.  For any given prior, it is possible to
specify a threshold on the posterior probability such that it the audit limits
the risk.  Alternatively, it is possible to select priors such that the
threshold itself is the risk limit.  Further details are in [Vora
(2019)](https://arxiv.org/abs/1902.00999) and a note by Vukcevic in a separate
Git repo.]

Bayesian audits can be represented in terms of the posterior odds, which gives
a similar formulation to other risk-limiting audits ([Vora,
2019](https://arxiv.org/abs/1902.00999)).  For the context described above,
they would use the following test statistic:
$$
B_n = \frac{\Pr(H_1 \mid X_1,\dots,X_n)}{\Pr(H_0 \mid X_1,\dots,X_n)}
    = \frac{\Pr(X_1,\dots,X_n \mid H_1)}{\Pr(X_1,\dots,X_n \mid H_0)} \times
      \frac{\Pr(H_1)}{\Pr(H_0)}.
$$
We will limit our discussion to risk-maximising prior distributions^[See [Vora
(2019)](https://arxiv.org/abs/1902.00999) for an example with a discrete
support.].  These place a probability mass of $\frac{1}{2}$ on the value of $t
= \frac{1}{2}$, and the remaining probability is over the set $t \in
(\frac{1}{2}, 1]$.  That means that $\Pr(H_1) = \Pr(H_0) = \frac{1}{2}$,
meaning that the prior odds drop out of the above equation.  The remaining term
is the Bayes factor (BF).  Let's write this out more explicitly.

Let $Y_n = \sum_{j=1}^n X_n$.  The denominator of the BF is simple: the
likelihood of the sample at the (point) null value,
$$
  \Pr(X_1,\dots,X_n \mid H_0)
= \Pr\left(X_1,\dots,X_n \mid t = \frac{1}{2}\right)
= \left(\frac{1}{2}\right)^{Y_n} \left(\frac{1}{2}\right)^{n - Y_n}
= \frac{1}{2^n}.
$$
The numerator requires integrating over the prior under $H_1$.  Let this be
$f(t)$, where $t \in (\frac{1}{2}, 1]$.  We can now write the numerator as
follows,
$$
  \Pr(X_1,\dots,X_n \mid H_1)
= \int_{\frac{1}{2}}^1 t^{Y_n} \left(1 - t\right)^{n - Y_n} f(t) \, dt.
$$
Putting these together gives,
$$
B_n = 2^n \int_{\frac{1}{2}}^1 t^{Y_n} \left(1 - t\right)^{n - Y_n} f(t) \, dt.
$$
Similar to KMart, a Bayesian audit proceeds until $B_n < 1 / \alpha$.


## Equivalence

Both $A_n$ and $B_n$ are expressed as integrals but with the $X_j$ in different
'places' in the integrand.  The key to showing they are equivalent is to notice
that the $X_j$ are binary variables, thus allowing us to set up an identity
that relates to the two 'ways' of writing the integral.  Specifically, we have
the following identity,
$$
  \gamma \left(X_j - \frac{1}{2}\right) + \frac{1}{2}
= \left(\frac{1 + \gamma}{2}\right)^{X_j}
  \left(\frac{1 - \gamma}{2}\right)^{1 - X_j}.
$$
This allows us to rewrite $A_n$,
$$
A_n
= 2^n \int_0^1 \left(\frac{1 + \gamma}{2}\right)^{Y_n}
    \left(\frac{1 - \gamma}{2}\right)^{n - Y_n} d\gamma
= \int_0^1 \left(1 + \gamma\right)^{Y_n}
    \left(1 - \gamma\right)^{n - Y_n} d\gamma.
$$
Next, let $\gamma = 2t - 1$ and change the variable of integration,
$$
A_n
= \int_{\frac{1}{2}}^1 (2t)^{Y_n} (2 - 2t)^{n - Y_n} 2 \, dt
= 2^n \int_{\frac{1}{2}}^1 t^{Y_n} \left(1 - t\right)^{n - Y_n} 2 \, dt.
$$
Finally, note that this is identical to $B_n$ if we set the prior to be uniform
over $H_1$, i.e. $f(t) = 2$.

In other words, a KMart audit is equivalent to a Bayesian audit that uses
a risk-maximising uniform prior.


# Extending KMart to arbitrary priors

From the above result, we can see that $\gamma$ plays a similar role to $t$.
The somewhat arbitrary integral over $\gamma$ used to define $A_n$ can be
generalised by specifying a weighting function $g(\gamma)$,
$$
A_n = \int_0^1 \prod_{j=1}^n \left(\gamma \left[\frac{X_j}{t_0} - 1\right]
    + 1\right) g(\gamma) \, d\gamma.
$$
Applying the same transformations as above gives,
$$
A_n = 2^n \int_{\frac{1}{2}}^1 t^{Y_n} \left(1 - t\right)^{n - Y_n}
    2 \times g(2t - 1) \, dt.
$$
In other words, this generalised version of KMart is equivalent to a Bayesian
audit with the following risk-maximising prior:
$$
f(t) = 2 \times g(2t - 1).
$$
The original KMart is the special case where $g(\cdot) = 1$.


# Discussion

This equivalence result sheds light on the nature of the KMart method.  It is
equivalent to a (risk-limiting) Bayesian audit with a specific prior.  The
extension described here allows use of an arbitrary prior.

Thus, we can think of KMart as providing an alternative expression for
risk-limiting Bayesian audits.  Perhaps this expression has some computational
advantages?

In terms of relative performance, the question can therefore be reduced to
asking about the relative performance of different prior distributions.  As
a starting point, the 'answer' will be somewhat boring: the methods that
perform best will be simply the ones for which the prior most closely matches
the truth.  (However, we need to be clear exactly how we measure
performance...)

For this reason, it is of interest to know how the different priors behave
across a range of scenarios, i.e. how sensitive/robust they are.  We probably
want to use priors that give relatively robust results.

I suspect that the uniform prior is going to be quite robust and a sensible
choice.

As a possible improvement in performance (but at the expense of robustness?),
we could try using priors that incorporate some knowledge of the election.  For
example, suppose the reported tally for the reported winner is $t^\star$. Under
$H_1$, we could use a uniform prior over $(\frac{1}{2}, t^\star]$.  Or, more
ambitiously, we could specify a narrow interval around $t^\star$ and place all
of our prior mass on that, which we can think of as a 'fuzzy' version of BRAVO.
