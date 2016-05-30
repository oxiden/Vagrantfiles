import tensorflow as tf

session = tf.Session()

hello = tf.constant('hello, oxiden world')
print session.run(hello)

a = tf.constant(11)
b = tf.constant(3)
print session.run(a*b)
