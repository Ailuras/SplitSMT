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

(declare-sort var2908 0)
(declare-sort var2064 0)
(declare-sort var3069 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/991142800 (var2064) void)
(declare-fun cast-from-var2908-to-var2064 (var2908) var2064)
(declare-fun String-init () String)
(declare-fun <init>/543593434 (String Int) void)
(declare-fun mBuffer/-1735303467 (var2908) String)
(declare-fun cast-from-String-to-var3069 (String) var3069)
(declare-fun lock/-1204327025 (var2064) var3069)
(declare-const null-var2908 var2908)
(declare-const null-Int Int)
(declare-const var3352 var2908) ; Statement: r0 := @this: org.apache.dubbo.common.io.UnsafeStringWriter 
(assert (not (= var3352 null-var2908)))
(declare-const var3643 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var3643 null-Int)))
(assert true)
;(assert (<init>/991142800 (cast-from-var2908-to-var2064 var3352))) ; Statement: specialinvoke r0.<java.io.Writer: void <init>()>() 

(declare-const var3352!1 var2908)
 ; Statement: if i0 >= 0 goto $r1 = new java.lang.StringBuilder 
(assert (>= var3643 0)) ; Cond: i0 >= 0 
(define-const var2327 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/543593434 var2327 var3643)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>(int)>(i0) 

(declare-const var2327!1 String)
(declare-const var3643!1 Int)
(declare-const var3352!2 var2908)
(assert (not (= var3352!2 null-var2908)))
(assert (= (mBuffer/-1735303467 var3352!2) var2327!1)) ; Statement: r0.<org.apache.dubbo.common.io.UnsafeStringWriter: java.lang.StringBuilder mBuffer> = $r1 
(declare-const var3352!3 var2908)
(assert (not (= var3352!3 null-var2908)))
(assert (= (lock/-1204327025 (cast-from-var2908-to-var2064 var3352!3)) (cast-from-String-to-var3069 var2327!1))) ; Statement: r0.<org.apache.dubbo.common.io.UnsafeStringWriter: java.lang.Object lock> = $r1 
 ; Statement: return 
(check-sat)
; {<init>/991142800=([java.io.Writer], void), cast-from-var2908-to-var2064=([org.apache.dubbo.common.io.UnsafeStringWriter], java.io.Writer), String-init=([], java.lang.StringBuilder), <init>/543593434=([java.lang.StringBuilder, int], void), mBuffer/-1735303467=([org.apache.dubbo.common.io.UnsafeStringWriter], java.lang.StringBuilder), cast-from-String-to-var3069=([java.lang.StringBuilder], java.lang.Object), lock/-1204327025=([java.io.Writer], java.lang.Object)}
; {var2908=org.apache.dubbo.common.io.UnsafeStringWriter, var3352=r0, var3643=i0, var2064=java.io.Writer, var2327=$r1, var3069=java.lang.Object}
; {org.apache.dubbo.common.io.UnsafeStringWriter=var2908, r0=var3352, i0=var3643, java.io.Writer=var2064, $r1=var2327, java.lang.Object=var3069}
;seq <java.lang.StringBuilder: void <init>(int)>
;cnt {"<java.lang.StringBuilder: void <init>(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.io.UnsafeStringWriter;	i0 := @parameter0: int;	specialinvoke r0.<java.io.Writer: void <init>()>();	if i0 >= 0 goto $r1 = new java.lang.StringBuilder;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>(int)>(i0);	r0.<org.apache.dubbo.common.io.UnsafeStringWriter: java.lang.StringBuilder mBuffer> = $r1;	r0.<org.apache.dubbo.common.io.UnsafeStringWriter: java.lang.Object lock> = $r1;	return
;block_num 2