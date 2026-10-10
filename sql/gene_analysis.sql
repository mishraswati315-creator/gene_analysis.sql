-- MySQL Bioinformatics Practice
-- Practice dataset: genes

USE bioinfo;

-- 1. View all genes
SELECT * FROM genes;

-- 2. Filter by organism
SELECT gene_name, organism, sequence_length
FROM genes
WHERE organism = 'Mycoplasma genitalium';

-- 3. Sort genes by sequence length
SELECT gene_name, organism, sequence_length
FROM genes
ORDER BY sequence_length DESC;

-- 4. Count genes per organism
SELECT organism, COUNT(*) AS total_genes
FROM genes
GROUP BY organism;

-- 5. Average sequence length per organism
SELECT organism, ROUND(AVG(sequence_length), 2) AS average_length
FROM genes
GROUP BY organism;

-- 6. Filter using HAVING
SELECT organism, COUNT(*) AS total_genes
FROM genes
GROUP BY organism
HAVING COUNT(*) > 1;

-- 7. Classify genes by sequence length
SELECT
    gene_name,
    sequence_length,
    CASE
        WHEN sequence_length > 2000 THEN 'Long'
        WHEN sequence_length >= 1500 THEN 'Medium'
        ELSE 'Short'
    END AS length_category
FROM genes;

-- 8. Find genes with gyrase in their description
SELECT gene_name, function_description
FROM genes
WHERE function_description LIKE '%gyrase%';

-- 9. Rank genes by sequence length
SELECT
    gene_name,
    sequence_length,
    RANK() OVER (ORDER BY sequence_length DESC) AS gene_rank
FROM genes;

-- 10. Find the top 2 longest genes
SELECT gene_name, organism, sequence_length
FROM (
    SELECT
        gene_name,
        organism,
        sequence_length,
        ROW_NUMBER() OVER (
            ORDER BY sequence_length DESC
        ) AS rn
    FROM genes
) AS ranked_genes
WHERE rn <= 2;
