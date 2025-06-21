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

(declare-sort var3138 0)
(declare-sort var237 0)
(declare-sort var1195 0)
(declare-sort var3746 0)
(declare-sort var488 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(declare-fun getHost/-1506772130 (var237) String)
(define-fun <init>/-1061048412 ((s String)) String s)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun getPort/20614931 (var237) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun getParameter/-1307325648 (var237 String) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun put/-572259024 (var1195 var488 var488) var488)
(declare-fun cast-from-String-to-var488 (String) var488)
(declare-const null-var3138 var3138)
(declare-const null-var237 var237)
(declare-const null-var1195 var1195)
(declare-const null-String String)
(declare-const var1116 var3138) ; Statement: r9 := @this: org.apache.dubbo.metadata.store.nacos.NacosMetadataReport 
(assert (not (= var1116 null-var3138)))
(declare-const var3308 var237) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3308 null-var237)))
(declare-const var1137 var1195) ; Statement: r6 := @parameter1: java.util.Properties 
(assert (not (= var1137 null-var1195)))
(define-const var2127 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
(define-const var1527 String (getHost/-1506772130 var3308)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getHost()>() 
(assert true)
;(assert (<init>/-1061048412 var2127 var1527)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>($r2) 
(declare-const var2127!1 String)
(assert (= var2127!1 var1527))
(assert true)
(define-const var631 String (append/-1166366385 var2127!1 58)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var2127!2 String)
(assert (str.prefixof var2127!1 var2127!2))
(assert true)
(define-const var1660 Int (getPort/20614931 var3308)) ; Statement: $i0 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getPort()>() 
(assert true)
(define-const var961 String (append/-1001720160 var631 var1660)) ; Statement: r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var631!1 String)
(assert (str.prefixof var631 var631!1))
(assert true)
(define-const var2651 String (getParameter/-1307325648 var3308 "backup")) ; Statement: r5 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("backup") 
 ; Statement: if r5 == null goto $r8 = virtualinvoke r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= var2651 null-String)) ; Cond: r5 == null 
(assert true)
(define-const var1626 String (toString/-2075883882 var961)) ; Statement: $r8 = virtualinvoke r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (put/-572259024 var1137 (cast-from-String-to-var488 "serverAddr") (cast-from-String-to-var488 var1626))) ; Statement: virtualinvoke r6.<java.util.Properties: java.lang.Object put(java.lang.Object,java.lang.Object)>("serverAddr", $r8) 

(declare-const var1137!1 var1195)
(declare-const var2552 String)
(declare-const var1626!1 String)
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), getHost/-1506772130=([org.apache.dubbo.common.URL], java.lang.String), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), getPort/20614931=([org.apache.dubbo.common.URL], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), put/-572259024=([java.util.Properties, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var488=([java.lang.String], java.lang.Object)}
; {var3138=org.apache.dubbo.metadata.store.nacos.NacosMetadataReport, var1116=r9, var237=org.apache.dubbo.common.URL, var3308=r1, var1195=java.util.Properties, var1137=r6, var2127=$r0, var1527=$r2, var631=$r3, var1660=$i0, var961=r4, var2651=r5, var3746=null_type, var1626=$r8, var488=java.lang.Object, var2552="serverAddr"}
; {org.apache.dubbo.metadata.store.nacos.NacosMetadataReport=var3138, r9=var1116, org.apache.dubbo.common.URL=var237, r1=var3308, java.util.Properties=var1195, r6=var1137, $r0=var2127, $r2=var1527, $r3=var631, $i0=var1660, r4=var961, r5=var2651, null_type=var3746, $r8=var1626, java.lang.Object=var488, "serverAddr"=var2552}
;seq <java.lang.StringBuilder: void <init>(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r9 := @this: org.apache.dubbo.metadata.store.nacos.NacosMetadataReport;	r1 := @parameter0: org.apache.dubbo.common.URL;	r6 := @parameter1: java.util.Properties;	$r0 = new java.lang.StringBuilder;	$r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getHost()>();	specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>($r2);	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$i0 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getPort()>();	r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	r5 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("backup");	if r5 == null goto $r8 = virtualinvoke r4.<java.lang.StringBuilder: java.lang.String toString()>();	$r8 = virtualinvoke r4.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke r6.<java.util.Properties: java.lang.Object put(java.lang.Object,java.lang.Object)>("serverAddr", $r8);	return
;block_num 2