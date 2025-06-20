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

(declare-sort var1421 0)
(declare-sort var2716 0)
(declare-sort var157 0)
(declare-sort var3199 0)
(declare-sort var2413 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(declare-fun getHost/-1506772130 (var2716) String)
(define-fun <init>/-1061048412 ((s String)) String s)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun getPort/20614931 (var2716) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun getParameter/-1307325648 (var2716 String) String)
(declare-fun var3199_isNotEmpty/-1251449450 (String) Bool)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun put/-572259024 (var157 var2413 var2413) var2413)
(declare-fun cast-from-String-to-var2413 (String) var2413)
(declare-const null-var1421 var1421)
(declare-const null-var2716 var2716)
(declare-const null-var157 var157)
(declare-const var3307 var1421) ; Statement: r9 := @this: org.apache.dubbo.registry.nacos.NacosConnectionManager 
(assert (not (= var3307 null-var1421)))
(declare-const var1405 var2716) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1405 null-var2716)))
(declare-const var584 var157) ; Statement: r6 := @parameter1: java.util.Properties 
(assert (not (= var584 null-var157)))
(define-const var2071 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
(define-const var3876 String (getHost/-1506772130 var1405)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getHost()>() 
(assert true)
;(assert (<init>/-1061048412 var2071 var3876)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>($r2) 
(declare-const var2071!1 String)
(assert (= var2071!1 var3876))
(assert true)
(define-const var974 String (append/-1166366385 var2071!1 58)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var2071!2 String)
(assert (str.prefixof var2071!1 var2071!2))
(assert true)
(define-const var1612 Int (getPort/20614931 var1405)) ; Statement: $i0 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getPort()>() 
(assert true)
(define-const var3157 String (append/-1001720160 var974 var1612)) ; Statement: r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var974!1 String)
(assert (str.prefixof var974 var974!1))
(assert true)
(define-const var53 String (getParameter/-1307325648 var1405 "backup")) ; Statement: r5 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("backup") 
(define-const var3660 Bool (var3199_isNotEmpty/-1251449450 var53)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r5) 
 ; Statement: if $z0 == 0 goto $r8 = virtualinvoke r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (not (= (ite var3660 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var906 String (append/-1166366385 var3157 44)) ; Statement: $r7 = virtualinvoke r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(44) 
(declare-const var3157!1 String)
(assert (str.prefixof var3157 var3157!1))
(assert true)
;(assert (append/672562846 var906 var53)) ; Statement: virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5) 
(declare-const var906!1 String)
(assert (= var906!1 (str.++ var906 var53)))
(assert true) ; Non Conditional
(assert true)
(define-const var271 String (toString/-2075883882 var3157!1)) ; Statement: $r8 = virtualinvoke r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (put/-572259024 var584 (cast-from-String-to-var2413 "serverAddr") (cast-from-String-to-var2413 var271))) ; Statement: virtualinvoke r6.<java.util.Properties: java.lang.Object put(java.lang.Object,java.lang.Object)>("serverAddr", $r8) 

(declare-const var584!1 var157)
(declare-const var372 String)
(declare-const var271!1 String)
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), getHost/-1506772130=([org.apache.dubbo.common.URL], java.lang.String), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), getPort/20614931=([org.apache.dubbo.common.URL], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var3199_isNotEmpty/-1251449450=([java.lang.String], boolean), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), put/-572259024=([java.util.Properties, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var2413=([java.lang.String], java.lang.Object)}
; {var1421=org.apache.dubbo.registry.nacos.NacosConnectionManager, var3307=r9, var2716=org.apache.dubbo.common.URL, var1405=r1, var157=java.util.Properties, var584=r6, var2071=$r0, var3876=$r2, var974=$r3, var1612=$i0, var3157=r4, var53=r5, var3199=org.apache.dubbo.common.utils.StringUtils, var3660=$z0, var906=$r7, var271=$r8, var2413=java.lang.Object, var372="serverAddr"}
; {org.apache.dubbo.registry.nacos.NacosConnectionManager=var1421, r9=var3307, org.apache.dubbo.common.URL=var2716, r1=var1405, java.util.Properties=var157, r6=var584, $r0=var2071, $r2=var3876, $r3=var974, $i0=var1612, r4=var3157, r5=var53, org.apache.dubbo.common.utils.StringUtils=var3199, $z0=var3660, $r7=var906, $r8=var271, java.lang.Object=var2413, "serverAddr"=var372}
;seq <java.lang.StringBuilder: void <init>(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r9 := @this: org.apache.dubbo.registry.nacos.NacosConnectionManager;	r1 := @parameter0: org.apache.dubbo.common.URL;	r6 := @parameter1: java.util.Properties;	$r0 = new java.lang.StringBuilder;	$r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getHost()>();	specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>($r2);	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$i0 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getPort()>();	r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	r5 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("backup");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r5);	if $z0 == 0 goto $r8 = virtualinvoke r4.<java.lang.StringBuilder: java.lang.String toString()>();	$r7 = virtualinvoke r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(44);	virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5);	$r8 = virtualinvoke r4.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke r6.<java.util.Properties: java.lang.Object put(java.lang.Object,java.lang.Object)>("serverAddr", $r8);	return
;block_num 3