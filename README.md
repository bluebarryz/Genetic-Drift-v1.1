# Genetic-Drift-v1.1
Genetic Drift cellular automata with improvements in the code (implementation of objects), and usability (addition of a user-interface).

<h1>Demo</h1>
<p>Each square-shaped ring of cells represents an isolated colony. Green cells have an "Aa" or "AA" genotype, yellow cells have an "aa" genotype.</p>
<img src="readme/demo1.gif" alt="demo1" width=500 height=500>

<h1>What it models</h1>
<p>This automaton models the effects of genetic drift on different population sizes. Genetic drift is a mechanism of evolution in which the genetic makeup of a community becomes increasingly homogenous as the population progresses from one generation to the next. Unlike natural selection, genetic drift is caused by  chance factors like sampling error and population size, both of which are apparent in this model.</p>

<p>An example of genetic drift is the founder effect, which occurs when a small group of organisms leaves a larger population to establish a new community elsewhere. Because of its small sample size, the genetic makeup of this founding group is likely different from that of the larger community it hails from (ex. 70% of the founding group might have a particular allele while only 50% of the larger community has that particular allele). If the genetic makeup of the founding group does indeed favour a particular allele, that allele may become more and more frequent in subsequent generations, approaching 100% frequency. Once the population reaches a 100% frequency of one allele, it is called a state of fixation.</p>

<p>In this model, multiple colonies of organisms are displayed at once. Each colony is represented by a square-shaped ring of cells and the colour of each cell is determined by its combination of alleles (genotype).</p>

<h1>States of a cell</h1>
<p>A cell can be either green or yellow. The colour of a cell is determined by its genotype. Each cell’s genotype contains a combination of two possible alleles (“A” or “a”). “A” is the dominant allele, meaning that a genotype with at least one “A” allele (ex. “AA” or “Aa”) will produce green, the dominant phenotype. On the other hand, “a” is the recessive allele, meaning that a genotype with two “a” alleles (ex. “aa”) will produce yellow, the recessive phenotype.</p>
<img src="readme/cell states.png" alt="cell states" width=400 height=300>

<h1>Evolution rules</h1>
<p>The allele combinations (aka genotypes) of the first generation are set randomly. For all subsequent generations, each cell mates with its clockwise neighbour to produce one offspring cell.</p>
<img src="readme/evolution rules.png" alt="evolution rules" width=600 height=450>

<p>The genotypes of the offspring are determined by the genotypes of its parents. However, since there are 4 possible (though not necessarily distinct) genotypes that can result from each reproduction, the genotype of the offspring is selected randomly from the four possibilities.</p>
<img src="readme/offspring cell.png" alt="offspring cell" width=600 height=450>

<p>Once the genotypes of the offspring generation are set, the offspring are assigned a random spot (aka index) inside their ring-shaped colony. In the next frame, the offspring of the offspring are displayed and the cycle repeats.</p>

<h1>Sample evolution</h1>
<img src="readme/sample evo.png" alt="sample evo" width=799 height=393>

