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

(declare-sort var308 0)
(declare-sort var3957 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(declare-fun mBuffer/-790845215 (var308) (Array Int Int))
(declare-fun mCount/-790845215 (var308) Int)
(declare-fun <init>/1365996485 (String (Array Int Int) Int Int String) void)
(declare-const null-var308 var308)
(declare-const null-String String)
(declare-const var3581 var308) ; Statement: r1 := @this: org.apache.dubbo.common.io.UnsafeByteArrayOutputStream 
(assert (not (= var3581 null-var308)))
(declare-const var3162 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var3162 null-String)))
(define-const var3833 String String-init) ; Statement: $r0 = new java.lang.String 
(define-const var3584 (Array Int Int) (mBuffer/-790845215 var3581)) ; Statement: $r3 = r1.<org.apache.dubbo.common.io.UnsafeByteArrayOutputStream: byte[] mBuffer> 
(define-const var3996 Int (mCount/-790845215 var3581)) ; Statement: $i0 = r1.<org.apache.dubbo.common.io.UnsafeByteArrayOutputStream: int mCount> 
(assert true)
;(assert (<init>/1365996485 var3833 var3584 0 var3996 var3162)) ; Statement: specialinvoke $r0.<java.lang.String: void <init>(byte[],int,int,java.lang.String)>($r3, 0, $i0, r2) 

(declare-const var3833!1 String)
(declare-const var3584!1 (Array Int Int))
(declare-const var3282 Int)
(declare-const var3996!1 Int)
(declare-const var3162!1 String)
 ; Statement: return $r0 
(check-sat)
; {String-init=([], java.lang.String), mBuffer/-790845215=([org.apache.dubbo.common.io.UnsafeByteArrayOutputStream], byte[]), mCount/-790845215=([org.apache.dubbo.common.io.UnsafeByteArrayOutputStream], int), <init>/1365996485=([java.lang.String, byte[], int, int, java.lang.String], void)}
; {var308=org.apache.dubbo.common.io.UnsafeByteArrayOutputStream, var3581=r1, var3162=r2, var3957=null_type, var3833=$r0, var3584=$r3, var3996=$i0, var3282=0}
; {org.apache.dubbo.common.io.UnsafeByteArrayOutputStream=var308, r1=var3581, r2=var3162, null_type=var3957, $r0=var3833, $r3=var3584, $i0=var3996, 0=var3282}
;seq <java.lang.String: void <init>(byte[],int,int,java.lang.String)>
;cnt {"<java.lang.String: void <init>(byte[],int,int,java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.io.UnsafeByteArrayOutputStream;	r2 := @parameter0: java.lang.String;	$r0 = new java.lang.String;	$r3 = r1.<org.apache.dubbo.common.io.UnsafeByteArrayOutputStream: byte[] mBuffer>;	$i0 = r1.<org.apache.dubbo.common.io.UnsafeByteArrayOutputStream: int mCount>;	specialinvoke $r0.<java.lang.String: void <init>(byte[],int,int,java.lang.String)>($r3, 0, $i0, r2);	return $r0
;block_num 1