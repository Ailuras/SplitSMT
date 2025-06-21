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

(declare-sort var2054 0)
(declare-sort var72 0)
(declare-sort var1271 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun expressions/-1812321979 (var2054) var72)
(declare-fun append/-1031950772 (String var1271) String)
(declare-fun cast-from-var72-to-var1271 (var72) var1271)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2054 var2054)
(declare-const var603 var2054) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ProducesCondition 
(assert (not (= var603 null-var2054)))
(define-const var1575 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1575)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1575!1 String)
(assert (= var1575!1 ""))
(assert true)
(define-const var1539 String (append/672562846 var1575!1 "ProducesCondition{mediaTypes=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ProducesCondition{mediaTypes=") 
(declare-const var1575!2 String)
(assert (= var1575!2 (str.++ var1575!1 "ProducesCondition{mediaTypes=")))
(define-const var1472 var72 (expressions/-1812321979 var603)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ProducesCondition: java.util.List expressions> 
(assert true)
(define-const var3950 String (append/-1031950772 var1539 (cast-from-var72-to-var1271 var1472))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var1539!1 String)
(assert (str.prefixof var1539 var1539!1))
(assert true)
(define-const var1402 String (append/-1166366385 var3950 125)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var3950!1 String)
(assert (str.prefixof var3950 var3950!1))
(assert true)
(define-const var3077 String (toString/-2075883882 var1402)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), expressions/-1812321979=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ProducesCondition], java.util.List), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var72-to-var1271=([java.util.List], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2054=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ProducesCondition, var603=r1, var1575=$r0, var1539=$r3, var72=java.util.List, var1472=$r2, var1271=java.lang.Object, var3950=$r4, var1402=$r5, var3077=$r6}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ProducesCondition=var2054, r1=var603, $r0=var1575, $r3=var1539, java.util.List=var72, $r2=var1472, java.lang.Object=var1271, $r4=var3950, $r5=var1402, $r6=var3077}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ProducesCondition;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ProducesCondition{mediaTypes=");	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ProducesCondition: java.util.List expressions>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1