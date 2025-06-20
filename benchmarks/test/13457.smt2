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

(declare-sort var2207 0)
(declare-sort var12 0)
(declare-sort var2028 0)
(declare-sort var2259 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun parameterMeta/1776216914 (var12) var2028)
(declare-fun getPrefix/2098086033 (var2028) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(declare-fun name/983931343 (var12) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2207 var2207)
(declare-const null-var12 var12)
(declare-const null-String String)
(declare-const var1327 var2207) ; Statement: r8 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.FormParamArgumentResolver 
(assert (not (= var1327 null-var2207)))
(declare-const var1916 var12) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta 
(assert (not (= var1916 null-var12)))
(assert true)
(define-const var50 var2028 (parameterMeta/1776216914 var1916)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta parameterMeta()>() 
(assert true)
(define-const var1050 String (getPrefix/2098086033 var50)) ; Statement: r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta: java.lang.String getPrefix()>() 
 ; Statement: if r2 != null goto $r3 = new java.lang.StringBuilder 
(assert (not (= var1050 null-String))) ; Cond: r2 != null 
(define-const var2794 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2794)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2794!1 String)
(assert (= var2794!1 ""))
(assert true)
(define-const var1163 String (append/672562846 var2794!1 var1050)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var2794!2 String)
(assert (= var2794!2 (str.++ var2794!1 var1050)))
(assert true)
(define-const var1429 String (append/-1166366385 var1163 46)) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(46) 
(declare-const var1163!1 String)
(assert (str.prefixof var1163 var1163!1))
(assert true)
(define-const var1139 String (name/983931343 var1916)) ; Statement: $r5 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta: java.lang.String name()>() 
(assert true)
(define-const var3099 String (append/672562846 var1429 var1139)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var1429!1 String)
(assert (= var1429!1 (str.++ var1429 var1139)))
(assert true)
(define-const var715 String (toString/-2075883882 var3099)) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true) ; Non Conditional
 ; Statement: return $r9 
(check-sat)
; {parameterMeta/1776216914=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta], org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta), getPrefix/2098086033=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), name/983931343=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2207=org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.FormParamArgumentResolver, var1327=r8, var12=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta, var1916=r0, var2028=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta, var50=$r1, var1050=r2, var2259=null_type, var2794=$r3, var1163=$r4, var1429=$r6, var1139=$r5, var3099=$r7, var715=$r9}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.FormParamArgumentResolver=var2207, r8=var1327, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta=var12, r0=var1916, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta=var2028, $r1=var50, r2=var1050, null_type=var2259, $r3=var2794, $r4=var1163, $r6=var1429, $r5=var1139, $r7=var3099, $r9=var715}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r8 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.jaxrs.FormParamArgumentResolver;	r0 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta;	$r1 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta parameterMeta()>();	r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta: java.lang.String getPrefix()>();	if r2 != null goto $r3 = new java.lang.StringBuilder;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(46);	$r5 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta: java.lang.String name()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 3