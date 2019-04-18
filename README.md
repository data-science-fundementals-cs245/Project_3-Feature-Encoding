# Project_3-Feature-Encoding

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