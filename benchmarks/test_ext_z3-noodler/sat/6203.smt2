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

(declare-sort var1706 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun canonicalName/331543809 (var1706) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun codeSource/331543809 (var1706) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1706 var1706)
(declare-const var3070 var1706) ; Statement: r1 := @this: org.apache.dubbo.metadata.definition.model.ServiceDefinition 
(assert (not (= var3070 null-var1706)))
(define-const var1685 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1685)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1685!1 String)
(assert (= var1685!1 ""))
(define-const var3710 String (canonicalName/331543809 var3070)) ; Statement: $r2 = r1.<org.apache.dubbo.metadata.definition.model.ServiceDefinition: java.lang.String canonicalName> 
(assert true)
(define-const var2946 String (append/672562846 var1685!1 var3710)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1685!2 String)
(assert (= var1685!2 (str.++ var1685!1 var3710)))
(assert true)
(define-const var685 String (append/672562846 var2946 "@")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("@") 
(declare-const var2946!1 String)
(assert (= var2946!1 (str.++ var2946 "@")))
(define-const var817 String (codeSource/331543809 var3070)) ; Statement: $r4 = r1.<org.apache.dubbo.metadata.definition.model.ServiceDefinition: java.lang.String codeSource> 
(assert true)
(define-const var235 String (append/672562846 var685 var817)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var685!1 String)
(assert (= var685!1 (str.++ var685 var817)))
(assert true)
(define-const var2820 String (toString/-2075883882 var235)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r7 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), canonicalName/331543809=([org.apache.dubbo.metadata.definition.model.ServiceDefinition], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), codeSource/331543809=([org.apache.dubbo.metadata.definition.model.ServiceDefinition], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1706=org.apache.dubbo.metadata.definition.model.ServiceDefinition, var3070=r1, var1685=$r0, var3710=$r2, var2946=$r3, var685=$r5, var817=$r4, var235=$r6, var2820=$r7}
; {org.apache.dubbo.metadata.definition.model.ServiceDefinition=var1706, r1=var3070, $r0=var1685, $r2=var3710, $r3=var2946, $r5=var685, $r4=var817, $r6=var235, $r7=var2820}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.metadata.definition.model.ServiceDefinition;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = r1.<org.apache.dubbo.metadata.definition.model.ServiceDefinition: java.lang.String canonicalName>;	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("@");	$r4 = r1.<org.apache.dubbo.metadata.definition.model.ServiceDefinition: java.lang.String codeSource>;	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	return $r7
;block_num 1