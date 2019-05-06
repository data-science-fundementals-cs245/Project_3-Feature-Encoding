Project_3-Feature-Encoding

#### Just for notice (In case you have forgot what is feature encoding)

After feature dimension reduction and distance metric learning, we now come to feature encoding.

For images: An image has many object proposals (described by boxes in the image), the feature of each object proposal is a local descriptor (or called local features).

Feature encoding is to: Encode **each bag of local features** into **a feature vector** based on codebook. Specifically, it is:

​	Step1: Learn a codebook

​	Step2: Encode local descriptors based on the learnt codebook

### Project Steps

1. Extract local descriptors. SIFT is mandatory. 方法有：opencv-python<http://www.cnblogs.com/youmuchen/p/8299197.html>.  Matlab: 不推荐，因为没有装^_^
2. 得到local descriptors后，用至少三种encoding方法（BOW，VLAD，FV）来获取feature vector。如果获取的feature维度太高，可以PCA降维。**尝试不同的聚类数并且观察不同的表现结果**。 
3. 将encoded features放入SVM进行分类。比较不同encoding方法之间的差异。

### Additional Experiments

1. 第一个可加实验量的点在于extract local descriptors. 我们从每幅图里extract proposal, 然后用deep learning获取其feature. Proposal的extraction可以用selective search, 可参考<http://disi.unitn.it/~uijlings/MyHomepage/index.php#page=projects1>. 
2.  （不太明白“different cluster numbers”的含义，指的是降到的维数吗）
3. 可以用Super method (0-order+1-order)作为第四个encoding方法。

### 实验结果
| k | 4 | 8 | 16 | 32 | 64 | 128 | 256 | 512 |
|-|-|-|-|-|-|-|-|-|
| SIFT+BOW | 6.20 | 9.84 | 15.77 | 18.67 | 20.28 | 23.25 | 23.92 | / |
| SIFT+VLAD | 23.03 | 24.31 | 26.72 | 26.19 | 28.27 | 29.14 | / | / |
| SIFT+Fisher Vector | 26.99 | 26.32 | 27.33 | 27.13 | 23.30 | 22.03 | 17.60 | / |
| DL+BOW | 11.47 | 23.90 |37.76 | 48.49 | 58.69 | 65.55 | 72.25 | / |
| DL+VLAD | 74.59 | 75.29 | 81.17 | 78.03 | 74.75 | 68.09 | 57.28 | / |
| DL+Fisher Vector | 62.86 | - | 11.19 | - | - | - | / | / |

### 实验分配
- 李杰宇：SIFT+BOW:4..512
- 李东岳：SIFT+VLAD/Fisher Vector:4..64(128有时间再做)
- 陈鸿滨：DL+BOW/VLAD:16..64(VLAD128有时间再做)
- 王皓轩：DL+BOW/VLAD：4，8
- 剩余：DL+Fisher Vector：4..64(128有时间再做)，DL+BOW:128..512





### Dongyue's Results

|  K   | Fisher | VLAD  |
| :--: | :----: | :---: |
|  4   | 26.99  | 23.03 |
|  8   | 26.32  | 24.31 |
|  16  | 27.33  | 26.72 |
|  17  | 27.73  |       |
|  18  | 26.93  |       |
|  19  | 27.40  |       |
|  20  | 27.26  |       |
|  21  | 25.18  |       |
|  22  | 26.05  |       |
|  23  | 27.73  |       |
|  24  | 26.99  |       |
|  25  | 25.85  |       |
| ...  |        |       |
|  32  | 27.13  | 26.19 |
|  64  | 23.30  | 28.27 |
| 128  |        | 29.14 |
| 256  |        |       |
|      |        |       |
|      |        |       |

