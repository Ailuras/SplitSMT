(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var100 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(declare-fun mBuffer/-790845215 (var100) (Array Int Int))
(declare-fun mCount/-790845215 (var100) Int)
(declare-fun <init>/-1380519146 (String (Array Int Int) Int Int) void)
(declare-const null-var100 var100)
(declare-const var2898 var100) ; Statement: r1 := @this: org.apache.dubbo.common.io.UnsafeByteArrayOutputStream 
(assert (not (= var2898 null-var100)))
(define-const var3988 String String-init) ; Statement: $r0 = new java.lang.String 
(define-const var1852 (Array Int Int) (mBuffer/-790845215 var2898)) ; Statement: $r2 = r1.<org.apache.dubbo.common.io.UnsafeByteArrayOutputStream: byte[] mBuffer> 
(define-const var260 Int (mCount/-790845215 var2898)) ; Statement: $i0 = r1.<org.apache.dubbo.common.io.UnsafeByteArrayOutputStream: int mCount> 
(assert true)
;(assert (<init>/-1380519146 var3988 var1852 0 var260)) ; Statement: specialinvoke $r0.<java.lang.String: void <init>(byte[],int,int)>($r2, 0, $i0) 

(declare-const var3988!1 String)
(declare-const var1852!1 (Array Int Int))
(declare-const var2447 Int)
(declare-const var260!1 Int)
 ; Statement: return $r0 
(check-sat)
; {String-init=([], java.lang.String), mBuffer/-790845215=([org.apache.dubbo.common.io.UnsafeByteArrayOutputStream], byte[]), mCount/-790845215=([org.apache.dubbo.common.io.UnsafeByteArrayOutputStream], int), <init>/-1380519146=([java.lang.String, byte[], int, int], void)}
; {var100=org.apache.dubbo.common.io.UnsafeByteArrayOutputStream, var2898=r1, var3988=$r0, var1852=$r2, var260=$i0, var2447=0}
; {org.apache.dubbo.common.io.UnsafeByteArrayOutputStream=var100, r1=var2898, $r0=var3988, $r2=var1852, $i0=var260, 0=var2447}
;seq <java.lang.String: void <init>(byte[],int,int)>
;cnt {"<java.lang.String: void <init>(byte[],int,int)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.io.UnsafeByteArrayOutputStream;	$r0 = new java.lang.String;	$r2 = r1.<org.apache.dubbo.common.io.UnsafeByteArrayOutputStream: byte[] mBuffer>;	$i0 = r1.<org.apache.dubbo.common.io.UnsafeByteArrayOutputStream: int mCount>;	specialinvoke $r0.<java.lang.String: void <init>(byte[],int,int)>($r2, 0, $i0);	return $r0
;block_num 1