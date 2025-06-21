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

(declare-sort var3466 0)
(declare-sort var897 0)
(declare-sort var1244 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun expressions/732756978 (var3466) var897)
(declare-fun append/-1031950772 (String var1244) String)
(declare-fun cast-from-var897-to-var1244 (var897) var1244)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3466 var3466)
(declare-const var160 var3466) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ParamsCondition 
(assert (not (= var160 null-var3466)))
(define-const var1882 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1882)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1882!1 String)
(assert (= var1882!1 ""))
(assert true)
(define-const var315 String (append/672562846 var1882!1 "ParamsCondition{params=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ParamsCondition{params=") 
(declare-const var1882!2 String)
(assert (= var1882!2 (str.++ var1882!1 "ParamsCondition{params=")))
(define-const var2960 var897 (expressions/732756978 var160)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ParamsCondition: java.util.Set expressions> 
(assert true)
(define-const var452 String (append/-1031950772 var315 (cast-from-var897-to-var1244 var2960))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var315!1 String)
(assert (str.prefixof var315 var315!1))
(assert true)
(define-const var1876 String (append/-1166366385 var452 125)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var452!1 String)
(assert (str.prefixof var452 var452!1))
(assert true)
(define-const var1490 String (toString/-2075883882 var1876)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), expressions/732756978=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ParamsCondition], java.util.Set), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var897-to-var1244=([java.util.Set], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3466=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ParamsCondition, var160=r1, var1882=$r0, var315=$r3, var897=java.util.Set, var2960=$r2, var1244=java.lang.Object, var452=$r4, var1876=$r5, var1490=$r6}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ParamsCondition=var3466, r1=var160, $r0=var1882, $r3=var315, java.util.Set=var897, $r2=var2960, java.lang.Object=var1244, $r4=var452, $r5=var1876, $r6=var1490}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ParamsCondition;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ParamsCondition{params=");	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ParamsCondition: java.util.Set expressions>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1