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

(declare-sort var1096 0)
(declare-sort var1053 0)
(declare-sort var1253 0)
(declare-sort var555 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun from/-987760580 (var1096) var1053)
(declare-fun append/-1031950772 (String var1253) String)
(declare-fun cast-from-var1053-to-var1253 (var1053) var1253)
(declare-fun to/-987760580 (var1096) var555)
(declare-fun cast-from-var555-to-var1253 (var555) var1253)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1096 var1096)
(declare-const var3272 var1096) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.condition.config.model.MultiDestCondition 
(assert (not (= var3272 null-var1096)))
(define-const var2630 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2630)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2630!1 String)
(assert (= var2630!1 ""))
(assert true)
(define-const var2455 String (append/672562846 var2630!1 "MultiDestCondition{from=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MultiDestCondition{from=") 
(declare-const var2630!2 String)
(assert (= var2630!2 (str.++ var2630!1 "MultiDestCondition{from=")))
(define-const var1665 var1053 (from/-987760580 var3272)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.cluster.router.condition.config.model.MultiDestCondition: java.util.Map 'from'> 
(assert true)
(define-const var3704 String (append/-1031950772 var2455 (cast-from-var1053-to-var1253 var1665))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var2455!1 String)
(assert (str.prefixof var2455 var2455!1))
(assert true)
(define-const var3729 String (append/672562846 var3704 ", to=")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", to=") 
(declare-const var3704!1 String)
(assert (= var3704!1 (str.++ var3704 ", to=")))
(define-const var1759 var555 (to/-987760580 var3272)) ; Statement: $r5 = r1.<org.apache.dubbo.rpc.cluster.router.condition.config.model.MultiDestCondition: java.util.List 'to'> 
(assert true)
(define-const var652 String (append/-1031950772 var3729 (cast-from-var555-to-var1253 var1759))) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5) 
(declare-const var3729!1 String)
(assert (str.prefixof var3729 var3729!1))
(assert true)
(define-const var3389 String (append/-1166366385 var652 125)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var652!1 String)
(assert (str.prefixof var652 var652!1))
(assert true)
(define-const var249 String (toString/-2075883882 var3389)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), from/-987760580=([org.apache.dubbo.rpc.cluster.router.condition.config.model.MultiDestCondition], java.util.Map), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1053-to-var1253=([java.util.Map], java.lang.Object), to/-987760580=([org.apache.dubbo.rpc.cluster.router.condition.config.model.MultiDestCondition], java.util.List), cast-from-var555-to-var1253=([java.util.List], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1096=org.apache.dubbo.rpc.cluster.router.condition.config.model.MultiDestCondition, var3272=r1, var2630=$r0, var2455=$r3, var1053=java.util.Map, var1665=$r2, var1253=java.lang.Object, var3704=$r4, var3729=$r6, var555=java.util.List, var1759=$r5, var652=$r7, var3389=$r8, var249=$r9}
; {org.apache.dubbo.rpc.cluster.router.condition.config.model.MultiDestCondition=var1096, r1=var3272, $r0=var2630, $r3=var2455, java.util.Map=var1053, $r2=var1665, java.lang.Object=var1253, $r4=var3704, $r6=var3729, java.util.List=var555, $r5=var1759, $r7=var652, $r8=var3389, $r9=var249}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.condition.config.model.MultiDestCondition;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MultiDestCondition{from=");	$r2 = r1.<org.apache.dubbo.rpc.cluster.router.condition.config.model.MultiDestCondition: java.util.Map 'from'>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", to=");	$r5 = r1.<org.apache.dubbo.rpc.cluster.router.condition.config.model.MultiDestCondition: java.util.List 'to'>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 1