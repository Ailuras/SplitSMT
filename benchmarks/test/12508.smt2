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

(declare-sort var2984 0)
(declare-sort var3120 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun listProvider/-23567832 (var2984) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun listConsumer/1348299267 (var2984) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2984 var2984)
(declare-const null-var3120 var3120)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var3337 var2984) ; Statement: r1 := @this: org.apache.dubbo.qos.command.impl.Ls 
(assert (not (= var3337 null-var2984)))
(declare-const var484 var3120) ; Statement: r5 := @parameter0: org.apache.dubbo.qos.api.CommandContext 
(assert (not (= var484 null-var3120)))
(declare-const var3341 (Array Int String)) ; Statement: r6 := @parameter1: java.lang.String[] 
(assert (not (= var3341 null-__Array__Int__String__)))
(define-const var3467 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3467)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3467!1 String)
(assert (= var3467!1 ""))
(assert true)
(define-const var2327 String (listProvider/-23567832 var3337)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.qos.command.impl.Ls: java.lang.String listProvider()>() 
(assert true)
;(assert (append/672562846 var3467!1 var2327)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var3467!2 String)
(assert (= var3467!2 (str.++ var3467!1 var2327)))
(assert true)
(define-const var201 String (listConsumer/1348299267 var3337)) ; Statement: $r3 = virtualinvoke r1.<org.apache.dubbo.qos.command.impl.Ls: java.lang.String listConsumer()>() 
(assert true)
;(assert (append/672562846 var3467!2 var201)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var3467!3 String)
(assert (= var3467!3 (str.++ var3467!2 var201)))
(assert true)
(define-const var1446 String (toString/-2075883882 var3467!3)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r4 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), listProvider/-23567832=([org.apache.dubbo.qos.command.impl.Ls], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), listConsumer/1348299267=([org.apache.dubbo.qos.command.impl.Ls], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2984=org.apache.dubbo.qos.command.impl.Ls, var3337=r1, var3120=org.apache.dubbo.qos.api.CommandContext, var484=r5, var3341=r6, var3467=$r0, var2327=$r2, var201=$r3, var1446=$r4}
; {org.apache.dubbo.qos.command.impl.Ls=var2984, r1=var3337, org.apache.dubbo.qos.api.CommandContext=var3120, r5=var484, r6=var3341, $r0=var3467, $r2=var2327, $r3=var201, $r4=var1446}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.qos.command.impl.Ls;	r5 := @parameter0: org.apache.dubbo.qos.api.CommandContext;	r6 := @parameter1: java.lang.String[];	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.qos.command.impl.Ls: java.lang.String listProvider()>();	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r3 = virtualinvoke r1.<org.apache.dubbo.qos.command.impl.Ls: java.lang.String listConsumer()>();	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r4
;block_num 1