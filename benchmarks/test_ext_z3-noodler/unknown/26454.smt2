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

(declare-sort var104 0)
(declare-sort var1133 0)
(declare-sort var2646 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun parameter/-1190524492 (var104) var1133)
(declare-fun append/-1031950772 (String var2646) String)
(declare-fun cast-from-var1133-to-var2646 (var1133) var2646)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var104 var104)
(declare-const var925 var104) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodParameterMeta 
(assert (not (= var925 null-var104)))
(define-const var3551 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3551)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3551!1 String)
(assert (= var3551!1 ""))
(assert true)
(define-const var2561 String (append/672562846 var3551!1 "MethodParameterMeta{parameter=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MethodParameterMeta{parameter=") 
(declare-const var3551!2 String)
(assert (= var3551!2 (str.++ var3551!1 "MethodParameterMeta{parameter=")))
(define-const var1751 var1133 (parameter/-1190524492 var925)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodParameterMeta: java.lang.reflect.Parameter parameter> 
(assert true)
(define-const var2660 String (append/-1031950772 var2561 (cast-from-var1133-to-var2646 var1751))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var2561!1 String)
(assert (str.prefixof var2561 var2561!1))
(assert true)
(define-const var2570 String (append/-1166366385 var2660 125)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var2660!1 String)
(assert (str.prefixof var2660 var2660!1))
(assert true)
(define-const var2319 String (toString/-2075883882 var2570)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), parameter/-1190524492=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodParameterMeta], java.lang.reflect.Parameter), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1133-to-var2646=([java.lang.reflect.Parameter], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var104=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodParameterMeta, var925=r1, var3551=$r0, var2561=$r3, var1133=java.lang.reflect.Parameter, var1751=$r2, var2646=java.lang.Object, var2660=$r4, var2570=$r5, var2319=$r6}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodParameterMeta=var104, r1=var925, $r0=var3551, $r3=var2561, java.lang.reflect.Parameter=var1133, $r2=var1751, java.lang.Object=var2646, $r4=var2660, $r5=var2570, $r6=var2319}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodParameterMeta;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MethodParameterMeta{parameter=");	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodParameterMeta: java.lang.reflect.Parameter parameter>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1