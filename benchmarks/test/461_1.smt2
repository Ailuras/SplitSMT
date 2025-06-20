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

(declare-sort var921 0)
(declare-sort var1157 0)
(declare-sort var1692 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun condition/-832258015 (var921) var1157)
(declare-fun append/-1031950772 (String var1692) String)
(declare-fun cast-from-var1157-to-var1692 (var1157) var1692)
(declare-fun subSetWeight/-832258015 (var921) Int)
(declare-fun cast-from-Int-to-var1692 (Int) var1692)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var921 var921)
(declare-const var2413 var921) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.condition.config.model.ConditionSubSet 
(assert (not (= var2413 null-var921)))
(define-const var2764 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2764)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2764!1 String)
(assert (= var2764!1 ""))
(assert true)
(define-const var1849 String (append/672562846 var2764!1 "ConditionSubSet{cond=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ConditionSubSet{cond=") 
(declare-const var2764!2 String)
(assert (= var2764!2 (str.++ var2764!1 "ConditionSubSet{cond=")))
(define-const var2793 var1157 (condition/-832258015 var2413)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.cluster.router.condition.config.model.ConditionSubSet: java.util.Map condition> 
(assert true)
(define-const var1953 String (append/-1031950772 var1849 (cast-from-var1157-to-var1692 var2793))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var1849!1 String)
(assert (str.prefixof var1849 var1849!1))
(assert true)
(define-const var2837 String (append/672562846 var1953 ", subSetWeight=")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", subSetWeight=") 
(declare-const var1953!1 String)
(assert (= var1953!1 (str.++ var1953 ", subSetWeight=")))
(define-const var1931 Int (subSetWeight/-832258015 var2413)) ; Statement: $r5 = r1.<org.apache.dubbo.rpc.cluster.router.condition.config.model.ConditionSubSet: java.lang.Integer subSetWeight> 
(assert true)
(define-const var198 String (append/-1031950772 var2837 (cast-from-Int-to-var1692 var1931))) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5) 
(declare-const var2837!1 String)
(assert (str.prefixof var2837 var2837!1))
(assert true)
(define-const var11 String (append/-1166366385 var198 125)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var198!1 String)
(assert (str.prefixof var198 var198!1))
(assert true)
(define-const var2972 String (toString/-2075883882 var11)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), condition/-832258015=([org.apache.dubbo.rpc.cluster.router.condition.config.model.ConditionSubSet], java.util.Map), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1157-to-var1692=([java.util.Map], java.lang.Object), subSetWeight/-832258015=([org.apache.dubbo.rpc.cluster.router.condition.config.model.ConditionSubSet], java.lang.Integer), cast-from-Int-to-var1692=([java.lang.Integer], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var921=org.apache.dubbo.rpc.cluster.router.condition.config.model.ConditionSubSet, var2413=r1, var2764=$r0, var1849=$r3, var1157=java.util.Map, var2793=$r2, var1692=java.lang.Object, var1953=$r4, var2837=$r6, var1931=$r5, var198=$r7, var11=$r8, var2972=$r9}
; {org.apache.dubbo.rpc.cluster.router.condition.config.model.ConditionSubSet=var921, r1=var2413, $r0=var2764, $r3=var1849, java.util.Map=var1157, $r2=var2793, java.lang.Object=var1692, $r4=var1953, $r6=var2837, $r5=var1931, $r7=var198, $r8=var11, $r9=var2972}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.condition.config.model.ConditionSubSet;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ConditionSubSet{cond=");	$r2 = r1.<org.apache.dubbo.rpc.cluster.router.condition.config.model.ConditionSubSet: java.util.Map condition>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", subSetWeight=");	$r5 = r1.<org.apache.dubbo.rpc.cluster.router.condition.config.model.ConditionSubSet: java.lang.Integer subSetWeight>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 1