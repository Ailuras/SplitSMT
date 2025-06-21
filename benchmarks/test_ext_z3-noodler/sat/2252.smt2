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

(declare-sort var2019 0)
(declare-sort var2552 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/1177653502 (var2552) void)
(declare-fun cast-from-var2019-to-var2552 (var2019) var2552)
(declare-fun arr-Int-init () (Array Int Int))
(declare-fun mBuffer/-790845215 (var2019) (Array Int Int))
(declare-const null-var2019 var2019)
(declare-const null-Int Int)
(declare-const var245 var2019) ; Statement: r0 := @this: org.apache.dubbo.common.io.UnsafeByteArrayOutputStream 
(assert (not (= var245 null-var2019)))
(declare-const var3990 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var3990 null-Int)))
(assert true)
;(assert (<init>/1177653502 (cast-from-var2019-to-var2552 var245))) ; Statement: specialinvoke r0.<java.io.OutputStream: void <init>()>() 

(declare-const var245!1 var2019)
 ; Statement: if i0 >= 0 goto $r1 = newarray (byte)[i0] 
(assert (>= var3990 0)) ; Cond: i0 >= 0 
(define-const var997 (Array Int Int) arr-Int-init) ; Statement: $r1 = newarray (byte)[i0] 
(declare-const var245!2 var2019)
(assert (not (= var245!2 null-var2019)))
(assert (= (mBuffer/-790845215 var245!2) var997)) ; Statement: r0.<org.apache.dubbo.common.io.UnsafeByteArrayOutputStream: byte[] mBuffer> = $r1 
 ; Statement: return 
(check-sat)
; {<init>/1177653502=([java.io.OutputStream], void), cast-from-var2019-to-var2552=([org.apache.dubbo.common.io.UnsafeByteArrayOutputStream], java.io.OutputStream), arr-Int-init=([], byte[]), mBuffer/-790845215=([org.apache.dubbo.common.io.UnsafeByteArrayOutputStream], byte[])}
; {var2019=org.apache.dubbo.common.io.UnsafeByteArrayOutputStream, var245=r0, var3990=i0, var2552=java.io.OutputStream, var997=$r1}
; {org.apache.dubbo.common.io.UnsafeByteArrayOutputStream=var2019, r0=var245, i0=var3990, java.io.OutputStream=var2552, $r1=var997}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.common.io.UnsafeByteArrayOutputStream;	i0 := @parameter0: int;	specialinvoke r0.<java.io.OutputStream: void <init>()>();	if i0 >= 0 goto $r1 = newarray (byte)[i0];	$r1 = newarray (byte)[i0];	r0.<org.apache.dubbo.common.io.UnsafeByteArrayOutputStream: byte[] mBuffer> = $r1;	return
;block_num 2