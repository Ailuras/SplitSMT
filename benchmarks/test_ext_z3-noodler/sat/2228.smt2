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

(declare-sort var1441 0)
(declare-sort var846 0)
(declare-sort var3829 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/991142800 (var846) void)
(declare-fun cast-from-var1441-to-var846 (var1441) var846)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun mBuffer/-1735303467 (var1441) String)
(declare-fun cast-from-String-to-var3829 (String) var3829)
(declare-fun lock/-1204327025 (var846) var3829)
(declare-const null-var1441 var1441)
(declare-const var234 var1441) ; Statement: r0 := @this: org.apache.dubbo.common.io.UnsafeStringWriter 
(assert (not (= var234 null-var1441)))
(assert true)
;(assert (<init>/991142800 (cast-from-var1441-to-var846 var234))) ; Statement: specialinvoke r0.<java.io.Writer: void <init>()>() 

(declare-const var234!1 var1441)
(define-const var2813 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2813)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2813!1 String)
(assert (= var2813!1 ""))
(declare-const var234!2 var1441)
(assert (not (= var234!2 null-var1441)))
(assert (= (mBuffer/-1735303467 var234!2) var2813!1)) ; Statement: r0.<org.apache.dubbo.common.io.UnsafeStringWriter: java.lang.StringBuilder mBuffer> = $r1 
(declare-const var234!3 var1441)
(assert (not (= var234!3 null-var1441)))
(assert (= (lock/-1204327025 (cast-from-var1441-to-var846 var234!3)) (cast-from-String-to-var3829 var2813!1))) ; Statement: r0.<org.apache.dubbo.common.io.UnsafeStringWriter: java.lang.Object lock> = $r1 
 ; Statement: return 
(check-sat)
; {<init>/991142800=([java.io.Writer], void), cast-from-var1441-to-var846=([org.apache.dubbo.common.io.UnsafeStringWriter], java.io.Writer), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), mBuffer/-1735303467=([org.apache.dubbo.common.io.UnsafeStringWriter], java.lang.StringBuilder), cast-from-String-to-var3829=([java.lang.StringBuilder], java.lang.Object), lock/-1204327025=([java.io.Writer], java.lang.Object)}
; {var1441=org.apache.dubbo.common.io.UnsafeStringWriter, var234=r0, var846=java.io.Writer, var2813=$r1, var3829=java.lang.Object}
; {org.apache.dubbo.common.io.UnsafeStringWriter=var1441, r0=var234, java.io.Writer=var846, $r1=var2813, java.lang.Object=var3829}
;seq <java.lang.StringBuilder: void <init>()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.io.UnsafeStringWriter;	specialinvoke r0.<java.io.Writer: void <init>()>();	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	r0.<org.apache.dubbo.common.io.UnsafeStringWriter: java.lang.StringBuilder mBuffer> = $r1;	r0.<org.apache.dubbo.common.io.UnsafeStringWriter: java.lang.Object lock> = $r1;	return
;block_num 1