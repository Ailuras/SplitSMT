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

(declare-sort var1325 0)
(declare-sort var1094 0)
(declare-sort var3000 0)
(declare-sort var3098 0)
(declare-sort var3179 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(declare-fun getHost/-1506772130 (var1094) String)
(define-fun <init>/-1061048412 ((s String)) String s)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun getPort/20614931 (var1094) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun getParameter/-1307325648 (var1094 String) String)
(declare-fun var3098_isNotEmpty/-1251449450 (String) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun put/-572259024 (var3000 var3179 var3179) var3179)
(declare-fun cast-from-String-to-var3179 (String) var3179)
(declare-const null-var1325 var1325)
(declare-const null-var1094 var1094)
(declare-const null-var3000 var3000)
(declare-const var2369 var1325) ; Statement: r9 := @this: org.apache.dubbo.registry.nacos.NacosConnectionManager 
(assert (not (= var2369 null-var1325)))
(declare-const var2555 var1094) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2555 null-var1094)))
(declare-const var1887 var3000) ; Statement: r6 := @parameter1: java.util.Properties 
(assert (not (= var1887 null-var3000)))
(define-const var1788 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
(define-const var3991 String (getHost/-1506772130 var2555)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getHost()>() 
(assert true)
;(assert (<init>/-1061048412 var1788 var3991)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>($r2) 
(declare-const var1788!1 String)
(assert (= var1788!1 var3991))
(assert true)
(define-const var3909 String (append/-1166366385 var1788!1 58)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var1788!2 String)
(assert (str.prefixof var1788!1 var1788!2))
(assert true)
(define-const var939 Int (getPort/20614931 var2555)) ; Statement: $i0 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getPort()>() 
(assert true)
(define-const var1663 String (append/-1001720160 var3909 var939)) ; Statement: r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var3909!1 String)
(assert (str.prefixof var3909 var3909!1))
(assert true)
(define-const var81 String (getParameter/-1307325648 var2555 "backup")) ; Statement: r5 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("backup") 
(define-const var1952 Bool (var3098_isNotEmpty/-1251449450 var81)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r5) 
 ; Statement: if $z0 == 0 goto $r8 = virtualinvoke r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var1952 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var1038 String (toString/-2075883882 var1663)) ; Statement: $r8 = virtualinvoke r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (put/-572259024 var1887 (cast-from-String-to-var3179 "serverAddr") (cast-from-String-to-var3179 var1038))) ; Statement: virtualinvoke r6.<java.util.Properties: java.lang.Object put(java.lang.Object,java.lang.Object)>("serverAddr", $r8) 

(declare-const var1887!1 var3000)
(declare-const var2601 String)
(declare-const var1038!1 String)
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), getHost/-1506772130=([org.apache.dubbo.common.URL], java.lang.String), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), getPort/20614931=([org.apache.dubbo.common.URL], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var3098_isNotEmpty/-1251449450=([java.lang.String], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), put/-572259024=([java.util.Properties, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var3179=([java.lang.String], java.lang.Object)}
; {var1325=org.apache.dubbo.registry.nacos.NacosConnectionManager, var2369=r9, var1094=org.apache.dubbo.common.URL, var2555=r1, var3000=java.util.Properties, var1887=r6, var1788=$r0, var3991=$r2, var3909=$r3, var939=$i0, var1663=r4, var81=r5, var3098=org.apache.dubbo.common.utils.StringUtils, var1952=$z0, var1038=$r8, var3179=java.lang.Object, var2601="serverAddr"}
; {org.apache.dubbo.registry.nacos.NacosConnectionManager=var1325, r9=var2369, org.apache.dubbo.common.URL=var1094, r1=var2555, java.util.Properties=var3000, r6=var1887, $r0=var1788, $r2=var3991, $r3=var3909, $i0=var939, r4=var1663, r5=var81, org.apache.dubbo.common.utils.StringUtils=var3098, $z0=var1952, $r8=var1038, java.lang.Object=var3179, "serverAddr"=var2601}
;seq <java.lang.StringBuilder: void <init>(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r9 := @this: org.apache.dubbo.registry.nacos.NacosConnectionManager;	r1 := @parameter0: org.apache.dubbo.common.URL;	r6 := @parameter1: java.util.Properties;	$r0 = new java.lang.StringBuilder;	$r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getHost()>();	specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>($r2);	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$i0 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getPort()>();	r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	r5 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("backup");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r5);	if $z0 == 0 goto $r8 = virtualinvoke r4.<java.lang.StringBuilder: java.lang.String toString()>();	$r8 = virtualinvoke r4.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke r6.<java.util.Properties: java.lang.Object put(java.lang.Object,java.lang.Object)>("serverAddr", $r8);	return
;block_num 2