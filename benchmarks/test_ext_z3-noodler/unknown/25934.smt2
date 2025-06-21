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

(declare-sort var3637 0)
(declare-sort var1195 0)
(declare-sort var1359 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun methods/1841000300 (var3637) var1195)
(declare-fun append/-1031950772 (String var1359) String)
(declare-fun cast-from-var1195-to-var1359 (var1195) var1359)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3637 var3637)
(declare-const var2734 var3637) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition 
(assert (not (= var2734 null-var3637)))
(define-const var3229 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3229)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3229!1 String)
(assert (= var3229!1 ""))
(assert true)
(define-const var3299 String (append/672562846 var3229!1 "MethodsCondition{methods=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MethodsCondition{methods=") 
(declare-const var3229!2 String)
(assert (= var3229!2 (str.++ var3229!1 "MethodsCondition{methods=")))
(define-const var1252 var1195 (methods/1841000300 var2734)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition: java.util.Set methods> 
(assert true)
(define-const var3112 String (append/-1031950772 var3299 (cast-from-var1195-to-var1359 var1252))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var3299!1 String)
(assert (str.prefixof var3299 var3299!1))
(assert true)
(define-const var2077 String (append/-1166366385 var3112 125)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var3112!1 String)
(assert (str.prefixof var3112 var3112!1))
(assert true)
(define-const var2174 String (toString/-2075883882 var2077)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), methods/1841000300=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition], java.util.Set), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1195-to-var1359=([java.util.Set], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3637=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition, var2734=r1, var3229=$r0, var3299=$r3, var1195=java.util.Set, var1252=$r2, var1359=java.lang.Object, var3112=$r4, var2077=$r5, var2174=$r6}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition=var3637, r1=var2734, $r0=var3229, $r3=var3299, java.util.Set=var1195, $r2=var1252, java.lang.Object=var1359, $r4=var3112, $r5=var2077, $r6=var2174}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MethodsCondition{methods=");	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition: java.util.Set methods>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1