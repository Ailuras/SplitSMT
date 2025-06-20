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

(declare-sort var2873 0)
(declare-sort var1881 0)
(declare-sort var3849 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun parameter/1240786698 (var2873) var1881)
(declare-fun append/-1031950772 (String var3849) String)
(declare-fun cast-from-var1881-to-var3849 (var1881) var3849)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2873 var2873)
(declare-const var148 var2873) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$ConstructorParameterMeta 
(assert (not (= var148 null-var2873)))
(define-const var3329 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3329)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3329!1 String)
(assert (= var3329!1 ""))
(assert true)
(define-const var2659 String (append/672562846 var3329!1 "ConstructorParameter{")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ConstructorParameter{") 
(declare-const var3329!2 String)
(assert (= var3329!2 (str.++ var3329!1 "ConstructorParameter{")))
(define-const var3223 var1881 (parameter/1240786698 var148)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$ConstructorParameterMeta: java.lang.reflect.Parameter parameter> 
(assert true)
(define-const var22 String (append/-1031950772 var2659 (cast-from-var1881-to-var3849 var3223))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var2659!1 String)
(assert (str.prefixof var2659 var2659!1))
(assert true)
(define-const var1592 String (append/-1166366385 var22 125)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var22!1 String)
(assert (str.prefixof var22 var22!1))
(assert true)
(define-const var1310 String (toString/-2075883882 var1592)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), parameter/1240786698=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$ConstructorParameterMeta], java.lang.reflect.Parameter), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1881-to-var3849=([java.lang.reflect.Parameter], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2873=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$ConstructorParameterMeta, var148=r1, var3329=$r0, var2659=$r3, var1881=java.lang.reflect.Parameter, var3223=$r2, var3849=java.lang.Object, var22=$r4, var1592=$r5, var1310=$r6}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$ConstructorParameterMeta=var2873, r1=var148, $r0=var3329, $r3=var2659, java.lang.reflect.Parameter=var1881, $r2=var3223, java.lang.Object=var3849, $r4=var22, $r5=var1592, $r6=var1310}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$ConstructorParameterMeta;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ConstructorParameter{");	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$ConstructorParameterMeta: java.lang.reflect.Parameter parameter>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1