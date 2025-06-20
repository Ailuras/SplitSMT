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

(declare-sort var1603 0)
(declare-sort var3427 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun deadlineInNanos/1854299391 (var1603) Int)
(declare-fun convert/683621972 (var3427 Int var3427) Int)
(declare-fun timeRemaining/2053950531 (var1603 var3427) Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-901862667 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1603 var1603)
(declare-const var3427-MILLISECONDS var3427)
(declare-const var3427-NANOSECONDS var3427)
(declare-const var2348 var1603) ; Statement: r0 := @this: org.apache.dubbo.rpc.TimeoutCountDown 
(assert (not (= var2348 null-var1603)))
(define-const var1267 var3427 var3427-MILLISECONDS) ; Statement: $r2 = <java.util.concurrent.TimeUnit: java.util.concurrent.TimeUnit MILLISECONDS> 
(define-const var525 Int (deadlineInNanos/1854299391 var2348)) ; Statement: $l0 = r0.<org.apache.dubbo.rpc.TimeoutCountDown: long deadlineInNanos> 
(define-const var193 var3427 var3427-NANOSECONDS) ; Statement: $r1 = <java.util.concurrent.TimeUnit: java.util.concurrent.TimeUnit NANOSECONDS> 
(assert true)
(define-const var1269 Int (convert/683621972 var1267 var525 var193)) ; Statement: l1 = virtualinvoke $r2.<java.util.concurrent.TimeUnit: long convert(long,java.util.concurrent.TimeUnit)>($l0, $r1) 
(define-const var74 var3427 var3427-MILLISECONDS) ; Statement: $r3 = <java.util.concurrent.TimeUnit: java.util.concurrent.TimeUnit MILLISECONDS> 
(assert true)
(define-const var1754 Int (timeRemaining/2053950531 var2348 var74)) ; Statement: l2 = virtualinvoke r0.<org.apache.dubbo.rpc.TimeoutCountDown: long timeRemaining(java.util.concurrent.TimeUnit)>($r3) 
(define-const var1542 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1542)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1542!1 String)
(assert (= var1542!1 ""))
(assert true)
;(assert (append/672562846 var1542!1 "Total timeout value - ")) ; Statement: virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Total timeout value - ") 
(declare-const var1542!2 String)
(assert (= var1542!2 (str.++ var1542!1 "Total timeout value - ")))
(assert true)
;(assert (append/-901862667 var1542!2 var1269)) ; Statement: virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>(l1) 
(declare-const var1542!3 String)
(assert (str.prefixof var1542!2 var1542!3))
(assert true)
;(assert (append/672562846 var1542!3 ", times remaining - ")) ; Statement: virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", times remaining - ") 
(declare-const var1542!4 String)
(assert (= var1542!4 (str.++ var1542!3 ", times remaining - ")))
(assert true)
;(assert (append/-901862667 var1542!4 var1754)) ; Statement: virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>(l2) 
(declare-const var1542!5 String)
(assert (str.prefixof var1542!4 var1542!5))
(assert true)
(define-const var3616 String (toString/-2075883882 var1542!5)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r5 
(check-sat)
; {deadlineInNanos/1854299391=([org.apache.dubbo.rpc.TimeoutCountDown], long), convert/683621972=([java.util.concurrent.TimeUnit, long, java.util.concurrent.TimeUnit], long), timeRemaining/2053950531=([org.apache.dubbo.rpc.TimeoutCountDown, java.util.concurrent.TimeUnit], long), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1603=org.apache.dubbo.rpc.TimeoutCountDown, var2348=r0, var3427=java.util.concurrent.TimeUnit, var1267=$r2, var525=$l0, var193=$r1, var1269=l1, var74=$r3, var1754=l2, var1542=$r4, var3616=$r5}
; {org.apache.dubbo.rpc.TimeoutCountDown=var1603, r0=var2348, java.util.concurrent.TimeUnit=var3427, $r2=var1267, $l0=var525, $r1=var193, l1=var1269, $r3=var74, l2=var1754, $r4=var1542, $r5=var3616}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.TimeoutCountDown;	$r2 = <java.util.concurrent.TimeUnit: java.util.concurrent.TimeUnit MILLISECONDS>;	$l0 = r0.<org.apache.dubbo.rpc.TimeoutCountDown: long deadlineInNanos>;	$r1 = <java.util.concurrent.TimeUnit: java.util.concurrent.TimeUnit NANOSECONDS>;	l1 = virtualinvoke $r2.<java.util.concurrent.TimeUnit: long convert(long,java.util.concurrent.TimeUnit)>($l0, $r1);	$r3 = <java.util.concurrent.TimeUnit: java.util.concurrent.TimeUnit MILLISECONDS>;	l2 = virtualinvoke r0.<org.apache.dubbo.rpc.TimeoutCountDown: long timeRemaining(java.util.concurrent.TimeUnit)>($r3);	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Total timeout value - ");	virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>(l1);	virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", times remaining - ");	virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>(l2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	return $r5
;block_num 1