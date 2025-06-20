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

(declare-sort var3741 0)
(declare-sort var1903 0)
(declare-sort var2375 0)
(declare-sort var2253 0)
(declare-sort var3730 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(declare-fun getHost/-1506772130 (var1903) String)
(define-fun <init>/-1061048412 ((s String)) String s)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun getPort/20614931 (var1903) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun getParameter/-1307325648 (var1903 String) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun put/-572259024 (var2375 var3730 var3730) var3730)
(declare-fun cast-from-String-to-var3730 (String) var3730)
(declare-const null-var3741 var3741)
(declare-const null-var1903 var1903)
(declare-const null-var2375 var2375)
(declare-const null-String String)
(declare-const var2312 var3741) ; Statement: r9 := @this: org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfiguration 
(assert (not (= var2312 null-var3741)))
(declare-const var2717 var1903) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2717 null-var1903)))
(declare-const var2706 var2375) ; Statement: r6 := @parameter1: java.util.Properties 
(assert (not (= var2706 null-var2375)))
(define-const var474 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
(define-const var1046 String (getHost/-1506772130 var2717)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getHost()>() 
(assert true)
;(assert (<init>/-1061048412 var474 var1046)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>($r2) 
(declare-const var474!1 String)
(assert (= var474!1 var1046))
(assert true)
(define-const var893 String (append/-1166366385 var474!1 58)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var474!2 String)
(assert (str.prefixof var474!1 var474!2))
(assert true)
(define-const var2098 Int (getPort/20614931 var2717)) ; Statement: $i0 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getPort()>() 
(assert true)
(define-const var3095 String (append/-1001720160 var893 var2098)) ; Statement: r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var893!1 String)
(assert (str.prefixof var893 var893!1))
(assert true)
(define-const var3946 String (getParameter/-1307325648 var2717 "backup")) ; Statement: r5 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("backup") 
 ; Statement: if r5 == null goto $r8 = virtualinvoke r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= var3946 null-String)) ; Cond: r5 == null 
(assert true)
(define-const var871 String (toString/-2075883882 var3095)) ; Statement: $r8 = virtualinvoke r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (put/-572259024 var2706 (cast-from-String-to-var3730 "serverAddr") (cast-from-String-to-var3730 var871))) ; Statement: virtualinvoke r6.<java.util.Properties: java.lang.Object put(java.lang.Object,java.lang.Object)>("serverAddr", $r8) 

(declare-const var2706!1 var2375)
(declare-const var110 String)
(declare-const var871!1 String)
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), getHost/-1506772130=([org.apache.dubbo.common.URL], java.lang.String), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), getPort/20614931=([org.apache.dubbo.common.URL], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), put/-572259024=([java.util.Properties, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var3730=([java.lang.String], java.lang.Object)}
; {var3741=org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfiguration, var2312=r9, var1903=org.apache.dubbo.common.URL, var2717=r1, var2375=java.util.Properties, var2706=r6, var474=$r0, var1046=$r2, var893=$r3, var2098=$i0, var3095=r4, var3946=r5, var2253=null_type, var871=$r8, var3730=java.lang.Object, var110="serverAddr"}
; {org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfiguration=var3741, r9=var2312, org.apache.dubbo.common.URL=var1903, r1=var2717, java.util.Properties=var2375, r6=var2706, $r0=var474, $r2=var1046, $r3=var893, $i0=var2098, r4=var3095, r5=var3946, null_type=var2253, $r8=var871, java.lang.Object=var3730, "serverAddr"=var110}
;seq <java.lang.StringBuilder: void <init>(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r9 := @this: org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfiguration;	r1 := @parameter0: org.apache.dubbo.common.URL;	r6 := @parameter1: java.util.Properties;	$r0 = new java.lang.StringBuilder;	$r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getHost()>();	specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>($r2);	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$i0 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getPort()>();	r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	r5 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("backup");	if r5 == null goto $r8 = virtualinvoke r4.<java.lang.StringBuilder: java.lang.String toString()>();	$r8 = virtualinvoke r4.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke r6.<java.util.Properties: java.lang.Object put(java.lang.Object,java.lang.Object)>("serverAddr", $r8);	return
;block_num 2