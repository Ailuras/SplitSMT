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

(declare-sort var1818 0)
(declare-sort var1689 0)
(declare-sort var1852 0)
(declare-sort var697 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun parameters/-232297038 (var1818) var1689)
(declare-fun append/-1031950772 (String var1852) String)
(declare-fun cast-from-var1689-to-var1852 (var1689) var1852)
(declare-fun toString/285872345 (var697) String)
(declare-fun cast-from-var1818-to-var697 (var1818) var697)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1818 var1818)
(declare-const var1620 var1818) ; Statement: r1 := @this: org.apache.dubbo.metadata.definition.model.FullServiceDefinition 
(assert (not (= var1620 null-var1818)))
(define-const var3991 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3991)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3991!1 String)
(assert (= var3991!1 ""))
(assert true)
(define-const var2160 String (append/672562846 var3991!1 "FullServiceDefinition{parameters=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("FullServiceDefinition{parameters=") 
(declare-const var3991!2 String)
(assert (= var3991!2 (str.++ var3991!1 "FullServiceDefinition{parameters=")))
(define-const var3404 var1689 (parameters/-232297038 var1620)) ; Statement: $r2 = r1.<org.apache.dubbo.metadata.definition.model.FullServiceDefinition: java.util.Map parameters> 
(assert true)
(define-const var2004 String (append/-1031950772 var2160 (cast-from-var1689-to-var1852 var3404))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var2160!1 String)
(assert (str.prefixof var2160 var2160!1))
(assert true)
(define-const var3114 String (append/672562846 var2004 "} ")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("} ") 
(declare-const var2004!1 String)
(assert (= var2004!1 (str.++ var2004 "} ")))
(assert true)
(define-const var2161 String (toString/285872345 (cast-from-var1818-to-var697 var1620))) ; Statement: $r5 = specialinvoke r1.<org.apache.dubbo.metadata.definition.model.ServiceDefinition: java.lang.String toString()>() 
(assert true)
(define-const var1072 String (append/672562846 var3114 var2161)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var3114!1 String)
(assert (= var3114!1 (str.++ var3114 var2161)))
(assert true)
(define-const var2107 String (toString/-2075883882 var1072)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), parameters/-232297038=([org.apache.dubbo.metadata.definition.model.FullServiceDefinition], java.util.Map), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1689-to-var1852=([java.util.Map], java.lang.Object), toString/285872345=([org.apache.dubbo.metadata.definition.model.ServiceDefinition], java.lang.String), cast-from-var1818-to-var697=([org.apache.dubbo.metadata.definition.model.FullServiceDefinition], org.apache.dubbo.metadata.definition.model.ServiceDefinition), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1818=org.apache.dubbo.metadata.definition.model.FullServiceDefinition, var1620=r1, var3991=$r0, var2160=$r3, var1689=java.util.Map, var3404=$r2, var1852=java.lang.Object, var2004=$r4, var3114=$r6, var697=org.apache.dubbo.metadata.definition.model.ServiceDefinition, var2161=$r5, var1072=$r7, var2107=$r8}
; {org.apache.dubbo.metadata.definition.model.FullServiceDefinition=var1818, r1=var1620, $r0=var3991, $r3=var2160, java.util.Map=var1689, $r2=var3404, java.lang.Object=var1852, $r4=var2004, $r6=var3114, org.apache.dubbo.metadata.definition.model.ServiceDefinition=var697, $r5=var2161, $r7=var1072, $r8=var2107}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.metadata.definition.model.ServiceDefinition: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.metadata.definition.model.FullServiceDefinition;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("FullServiceDefinition{parameters=");	$r2 = r1.<org.apache.dubbo.metadata.definition.model.FullServiceDefinition: java.util.Map parameters>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("} ");	$r5 = specialinvoke r1.<org.apache.dubbo.metadata.definition.model.ServiceDefinition: java.lang.String toString()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 1