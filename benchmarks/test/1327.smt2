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

(declare-sort var836 0)
(declare-sort var305 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun doBuildSnapshot/2033976910 (var836) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun nextRouter/95515065 (var836) var305)
(declare-fun var305_buildSnapshot/-1258570783 (var305) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var836 var836)
(declare-const var1359 var836) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.state.AbstractStateRouter 
(assert (not (= var1359 null-var836)))
(define-const var3807 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3807)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3807!1 String)
(assert (= var3807!1 ""))
(assert true)
(define-const var3382 String (doBuildSnapshot/2033976910 var1359)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.rpc.cluster.router.state.AbstractStateRouter: java.lang.String doBuildSnapshot()>() 
(assert true)
(define-const var1114 String (append/672562846 var3807!1 var3382)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var3807!2 String)
(assert (= var3807!2 (str.++ var3807!1 var3382)))
(assert true)
(define-const var3636 String (append/672562846 var1114 "            v \n")) ; Statement: $r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("            v \n") 
(declare-const var1114!1 String)
(assert (= var1114!1 (str.++ var1114 "            v \n")))
(define-const var2690 var305 (nextRouter/95515065 var1359)) ; Statement: $r4 = r1.<org.apache.dubbo.rpc.cluster.router.state.AbstractStateRouter: org.apache.dubbo.rpc.cluster.router.state.StateRouter nextRouter> 
(define-const var2065 String (var305_buildSnapshot/-1258570783 var2690)) ; Statement: $r5 = interfaceinvoke $r4.<org.apache.dubbo.rpc.cluster.router.state.StateRouter: java.lang.String buildSnapshot()>() 
(assert true)
(define-const var3167 String (append/672562846 var3636 var2065)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var3636!1 String)
(assert (= var3636!1 (str.++ var3636 var2065)))
(assert true)
(define-const var933 String (toString/-2075883882 var3167)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), doBuildSnapshot/2033976910=([org.apache.dubbo.rpc.cluster.router.state.AbstractStateRouter], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), nextRouter/95515065=([org.apache.dubbo.rpc.cluster.router.state.AbstractStateRouter], org.apache.dubbo.rpc.cluster.router.state.StateRouter), var305_buildSnapshot/-1258570783=([org.apache.dubbo.rpc.cluster.router.state.StateRouter], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var836=org.apache.dubbo.rpc.cluster.router.state.AbstractStateRouter, var1359=r1, var3807=$r0, var3382=$r2, var1114=$r3, var3636=$r6, var305=org.apache.dubbo.rpc.cluster.router.state.StateRouter, var2690=$r4, var2065=$r5, var3167=$r7, var933=$r8}
; {org.apache.dubbo.rpc.cluster.router.state.AbstractStateRouter=var836, r1=var1359, $r0=var3807, $r2=var3382, $r3=var1114, $r6=var3636, org.apache.dubbo.rpc.cluster.router.state.StateRouter=var305, $r4=var2690, $r5=var2065, $r7=var3167, $r8=var933}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.state.AbstractStateRouter;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.rpc.cluster.router.state.AbstractStateRouter: java.lang.String doBuildSnapshot()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("            v \n");	$r4 = r1.<org.apache.dubbo.rpc.cluster.router.state.AbstractStateRouter: org.apache.dubbo.rpc.cluster.router.state.StateRouter nextRouter>;	$r5 = interfaceinvoke $r4.<org.apache.dubbo.rpc.cluster.router.state.StateRouter: java.lang.String buildSnapshot()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 1