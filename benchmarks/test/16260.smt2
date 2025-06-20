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

(declare-sort var3922 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(declare-fun category/-687932879 (var3922) String)
(define-fun <init>/-1061048412 ((s String)) String s)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun serviceInterface/-687932879 (var3922) String)
(declare-fun version/-687932879 (var3922) String)
(declare-fun group/-687932879 (var3922) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3922 var3922)
(declare-const var2249 var3922) ; Statement: r1 := @this: org.apache.dubbo.registry.nacos.NacosServiceName 
(assert (not (= var2249 null-var3922)))
(define-const var2328 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(define-const var3544 String (category/-687932879 var2249)) ; Statement: $r2 = r1.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String category> 
(assert true)
;(assert (<init>/-1061048412 var2328 var3544)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>($r2) 
(declare-const var2328!1 String)
(assert (= var2328!1 var3544))
(assert true)
(define-const var790 String (append/672562846 var2328!1 ":")) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":") 
(declare-const var2328!2 String)
(assert (= var2328!2 (str.++ var2328!1 ":")))
(define-const var1356 String (serviceInterface/-687932879 var2249)) ; Statement: $r3 = r1.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String serviceInterface> 
(assert true)
(define-const var3401 String (append/672562846 var790 var1356)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var790!1 String)
(assert (= var790!1 (str.++ var790 var1356)))
(assert true)
(define-const var186 String (append/672562846 var3401 ":")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":") 
(declare-const var3401!1 String)
(assert (= var3401!1 (str.++ var3401 ":")))
(define-const var3722 String (version/-687932879 var2249)) ; Statement: $r6 = r1.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String version> 
(assert true)
(define-const var1603 String (append/672562846 var186 var3722)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var186!1 String)
(assert (= var186!1 (str.++ var186 var3722)))
(assert true)
(define-const var3361 String (append/672562846 var1603 ":")) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":") 
(declare-const var1603!1 String)
(assert (= var1603!1 (str.++ var1603 ":")))
(define-const var2073 String (group/-687932879 var2249)) ; Statement: $r9 = r1.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String group> 
(assert true)
(define-const var70 String (append/672562846 var3361 var2073)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(declare-const var3361!1 String)
(assert (= var3361!1 (str.++ var3361 var2073)))
(assert true)
(define-const var2692 String (toString/-2075883882 var70)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r12 
(check-sat)
; {String-init=([], java.lang.StringBuilder), category/-687932879=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.String), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), serviceInterface/-687932879=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.String), version/-687932879=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.String), group/-687932879=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3922=org.apache.dubbo.registry.nacos.NacosServiceName, var2249=r1, var2328=$r0, var3544=$r2, var790=$r4, var1356=$r3, var3401=$r5, var186=$r7, var3722=$r6, var1603=$r8, var3361=$r10, var2073=$r9, var70=$r11, var2692=$r12}
; {org.apache.dubbo.registry.nacos.NacosServiceName=var3922, r1=var2249, $r0=var2328, $r2=var3544, $r4=var790, $r3=var1356, $r5=var3401, $r7=var186, $r6=var3722, $r8=var1603, $r10=var3361, $r9=var2073, $r11=var70, $r12=var2692}
;seq <java.lang.StringBuilder: void <init>(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.registry.nacos.NacosServiceName;	$r0 = new java.lang.StringBuilder;	$r2 = r1.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String category>;	specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>($r2);	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":");	$r3 = r1.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String serviceInterface>;	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":");	$r6 = r1.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String version>;	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":");	$r9 = r1.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String group>;	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	return $r12
;block_num 1