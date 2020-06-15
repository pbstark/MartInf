% Risk-limiting Bayesian audits with arbitrary priors
% Damjan Vukcevic
% 18 Apr 2019

These notes extend the work of [Vora (2019)](https://arxiv.org/abs/1902.00999).


# Risk of a Bayesian audit with any prior

The *risk* of any audit is the largest probability that an audit will certify
an incorrect election outcome.

Vora (2019) provides a construction of a risk-limiting Bayesian audit, by
taking a Bayesian audit with an arbitrary prior ($f_X$) and constructing a new
prior based on it ($f_X^*$) that has the property that a threshold on the upset
probability is also an upper bound on the risk (i.e. a risk limit).

The argument can be extended to show that *any* prior has a bounded risk and
can therefore be used to conduct a risk-limiting audit.  Such a usage would
involve calculating an appropriate threshold on the upset probability that
results in a particular specified bound on the risk.


## Lemma

In a 2-candidate election, the risk of an audit is given by the
(mis)certification probability when the true tally is equal votes for each
candidate, or the closest possible such non-winning tally (notionally $p
= 0.5$; in the notation of Vora (2019) this would be the case of $x = \frac{N
- 1}{2}$ for odd $N$, and $x = \frac{N}{2}$ for even $N$).

Proof:

This assertion can be proved by the same monotonicity argument used in the
proof of Theorem 2 of Vora (2019): $hg(k, n, x, N)$ is a monotone increasing
function of $x$ for $x \in [0, \frac{N - 1}{2}]$, and applying this termwise to the
formula for the risk at $x$, $P_T(\Lambda, x)$ leads to the conclusion.


## Corollary

For any prior, the risk of the Bayesian audit with this prior is given by
$P_T(\Lambda, \frac{N - 1}{2})$.


## Lemma

The risk of a Bayesian audit is a monotone increasing function of $\gamma$, the
threshold on the upset probability.  (In other words, relaxing the threshold
leads to higher risk.)

Proof:

If $\gamma$ is increased, then:

* Any sequence in $\Lambda$ remains in $\Lambda$, with the sample size at which
the audit stops possibly reducing (i.e. the audit terminates earlier).

* Some sequences in $\bar\Lambda$ move to $\Lambda$, due to the relaxed
threshold.

Therefore, overall there will be a shift of probability from $\bar\Lambda$ to
$\Lambda$.  This is true for any given true $x$, and in particular for the
value which gives the largest miscertification probability ($x = \frac{N
- 1}{2}$).  Therefore, the risk has increased.


## Corollary

The monotonic relationship implies that we can reduce the risk by imposing
a stricter threshold on the upset probability.  In particular, we can reduce it
until is less than any pre-specified limit.  Thus, we can use any Bayesian
audit in a risk-limiting fashion.

Note that to implement this in practice we need to be able calculate the risk
for any given threshold and optimise the threshold value to reduce the risk
under the specified limit.  This should be straightforward enough for the
2-candidate case via either simulation or exact calculation, since we know
which value of $x$ gives rise to the maximum miscertification probability.
Note that such a calculation would need to be done separately for any given
choice of sampling scheme and prior.


# The risk-maximizing distribution

This is minor detail...

I believe the definition of $f_X^*$ given in Vora (2019) has an error.  It only
defines a valid distribution if the original prior places total probability
mass of 0.5 over the winning alternatives ($\sum_{x \geqslant \frac{N+1}{2}}
f_X(x) = 0.5$).  Otherwise, we need to renormalise that portion of the distribution
to ensure the probabilities sum to 1.
