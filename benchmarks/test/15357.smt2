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

(declare-sort var855 0)
(declare-sort var72 0)
(declare-sort var3123 0)
(declare-sort var3718 0)
(declare-sort var3611 0)
(declare-sort var2479 0)
(declare-sort var1716 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var3123!class ClassObject)
(declare-fun getClass/1258963082 (var72) ClassObject)
(declare-fun cast-from-var855-to-var72 (var855) var72)
(declare-fun getSimpleName/-390194377 (ClassObject) String)
(define-fun indexOf/-1209756239 ((s String) (subs String)) Int (str.indexof s subs 0))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun String-init () String)
(declare-fun <init>/543593434 (String Int) void)
(declare-fun applicationModel/642990325 (var855) var3718)
(declare-fun getApplicationConfigManager/1850072349 (var3718) var3611)
(declare-fun getApplication/-787724749 (var3611) var2479)
(declare-fun isPresent/580259846 (var2479) Bool)
(define-fun toLowerCase/415700667 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "A" "a") "B" "b") "C" "c") "D" "d") "E" "e") "F" "f") "G" "g") "H" "h") "I" "i") "J" "j") "K" "k") "L" "l") "M" "m") "N" "n") "O" "o") "P" "p") "Q" "q") "R" "r") "S" "s") "T" "t") "U" "u") "V" "v") "W" "w") "X" "x") "Y" "y") "Z" "z"))
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getUrl/550456951 (var855) var1716)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var855 var855)
(declare-const null-var1716 var1716)
(declare-const var166 var855) ; Statement: r0 := @this: org.apache.dubbo.registry.client.AbstractServiceDiscovery 
(assert (not (= var166 null-var855)))
(assert true)
(define-const var812 ClassObject (getClass/1258963082 (cast-from-var855-to-var72 var166))) ; Statement: $r1 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var1696 String (getSimpleName/-390194377 var812)) ; Statement: r15 = virtualinvoke $r1.<java.lang.Class: java.lang.String getSimpleName()>() 
(define-const var2907 ClassObject var3123!class) ; Statement: $r2 = class "Lorg/apache/dubbo/registry/client/ServiceDiscovery;" 
(assert true)
(define-const var2069 String (getSimpleName/-390194377 var2907)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getSimpleName()>() 
(assert true)
(define-const var1390 Int (indexOf/-1209756239 var1696 var2069)) ; Statement: i0 = virtualinvoke r15.<java.lang.String: int indexOf(java.lang.String)>($r3) 
(define-const var2007 Int (cast-from-Int-to-Int -1)) ; Statement: $i2 = (int) -1 
 ; Statement: if i0 == $i2 goto $r16 = new java.lang.StringBuilder 
(assert (= var1390 var2007)) ; Cond: i0 == $i2 
(define-const var2674 String String-init) ; Statement: $r16 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/543593434 var2674 128)) ; Statement: specialinvoke $r16.<java.lang.StringBuilder: void <init>(int)>(128) 

(declare-const var2674!1 String)
(declare-const var2084 Int)
(define-const var693 var3718 (applicationModel/642990325 var166)) ; Statement: $r5 = r0.<org.apache.dubbo.registry.client.AbstractServiceDiscovery: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert true)
(define-const var2391 var3611 (getApplicationConfigManager/1850072349 var693)) ; Statement: $r6 = virtualinvoke $r5.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.config.context.ConfigManager getApplicationConfigManager()>() 
(assert true)
(define-const var3135 var2479 (getApplication/-787724749 var2391)) ; Statement: $r14 = virtualinvoke $r6.<org.apache.dubbo.config.context.ConfigManager: java.util.Optional getApplication()>() 
(assert true)
(define-const var3613 Bool (isPresent/580259846 var3135)) ; Statement: $z0 = virtualinvoke $r14.<java.util.Optional: boolean isPresent()>() 
 ; Statement: if $z0 == 0 goto $r7 = virtualinvoke r15.<java.lang.String: java.lang.String toLowerCase()>() 
(assert (= (ite var3613 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var1838 String (toLowerCase/415700667 var1696)) ; Statement: $r7 = virtualinvoke r15.<java.lang.String: java.lang.String toLowerCase()>() 
(assert true)
;(assert (append/672562846 var2674!1 var1838)) ; Statement: virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var2674!2 String)
(assert (= var2674!2 (str.++ var2674!1 var1838)))
(assert true)
(define-const var1199 var1716 (getUrl/550456951 var166)) ; Statement: $r13 = virtualinvoke r0.<org.apache.dubbo.registry.client.AbstractServiceDiscovery: org.apache.dubbo.common.URL getUrl()>() 
 ; Statement: if $r13 == null goto $r8 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= var1199 null-var1716)) ; Cond: $r13 == null 
(assert true)
(define-const var968 String (toString/-2075883882 var2674!2)) ; Statement: $r8 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var855-to-var72=([org.apache.dubbo.registry.client.AbstractServiceDiscovery], java.lang.Object), getSimpleName/-390194377=([java.lang.Class], java.lang.String), indexOf/-1209756239=([java.lang.String, java.lang.String], int), cast-from-Int-to-Int=([int], int), String-init=([], java.lang.StringBuilder), <init>/543593434=([java.lang.StringBuilder, int], void), applicationModel/642990325=([org.apache.dubbo.registry.client.AbstractServiceDiscovery], org.apache.dubbo.rpc.model.ApplicationModel), getApplicationConfigManager/1850072349=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.config.context.ConfigManager), getApplication/-787724749=([org.apache.dubbo.config.context.ConfigManager], java.util.Optional), isPresent/580259846=([java.util.Optional], boolean), toLowerCase/415700667=([java.lang.String], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getUrl/550456951=([org.apache.dubbo.registry.client.AbstractServiceDiscovery], org.apache.dubbo.common.URL), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var855=org.apache.dubbo.registry.client.AbstractServiceDiscovery, var166=r0, var72=java.lang.Object, var812=$r1, var1696=r15, var3123=org.apache.dubbo.registry.client.ServiceDiscovery, var2907=$r2, var2069=$r3, var1390=i0, var2007=$i2, var2674=$r16, var2084=128, var3718=org.apache.dubbo.rpc.model.ApplicationModel, var693=$r5, var3611=org.apache.dubbo.config.context.ConfigManager, var2391=$r6, var2479=java.util.Optional, var3135=$r14, var3613=$z0, var1838=$r7, var1716=org.apache.dubbo.common.URL, var1199=$r13, var968=$r8}
; {org.apache.dubbo.registry.client.AbstractServiceDiscovery=var855, r0=var166, java.lang.Object=var72, $r1=var812, r15=var1696, org.apache.dubbo.registry.client.ServiceDiscovery=var3123, $r2=var2907, $r3=var2069, i0=var1390, $i2=var2007, $r16=var2674, 128=var2084, org.apache.dubbo.rpc.model.ApplicationModel=var3718, $r5=var693, org.apache.dubbo.config.context.ConfigManager=var3611, $r6=var2391, java.util.Optional=var2479, $r14=var3135, $z0=var3613, $r7=var1838, org.apache.dubbo.common.URL=var1716, $r13=var1199, $r8=var968}
;seq <java.lang.String: int indexOf(java.lang.String)>;	<java.lang.StringBuilder: void <init>(int)>;	<java.lang.String: java.lang.String toLowerCase()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: int indexOf(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>(int)>": 1,"<java.lang.String: java.lang.String toLowerCase()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.AbstractServiceDiscovery;	$r1 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	r15 = virtualinvoke $r1.<java.lang.Class: java.lang.String getSimpleName()>();	$r2 = class "Lorg/apache/dubbo/registry/client/ServiceDiscovery;";	$r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getSimpleName()>();	i0 = virtualinvoke r15.<java.lang.String: int indexOf(java.lang.String)>($r3);	$i2 = (int) -1;	if i0 == $i2 goto $r16 = new java.lang.StringBuilder;	$r16 = new java.lang.StringBuilder;	specialinvoke $r16.<java.lang.StringBuilder: void <init>(int)>(128);	$r5 = r0.<org.apache.dubbo.registry.client.AbstractServiceDiscovery: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	$r6 = virtualinvoke $r5.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.config.context.ConfigManager getApplicationConfigManager()>();	$r14 = virtualinvoke $r6.<org.apache.dubbo.config.context.ConfigManager: java.util.Optional getApplication()>();	$z0 = virtualinvoke $r14.<java.util.Optional: boolean isPresent()>();	if $z0 == 0 goto $r7 = virtualinvoke r15.<java.lang.String: java.lang.String toLowerCase()>();	$r7 = virtualinvoke r15.<java.lang.String: java.lang.String toLowerCase()>();	virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r13 = virtualinvoke r0.<org.apache.dubbo.registry.client.AbstractServiceDiscovery: org.apache.dubbo.common.URL getUrl()>();	if $r13 == null goto $r8 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.String toString()>();	$r8 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 4