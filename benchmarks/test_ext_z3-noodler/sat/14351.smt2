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

(declare-sort var876 0)
(declare-sort var2740 0)
(declare-sort var1302 0)
(declare-sort var2507 0)
(declare-sort var921 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2740-init () var2740)
(declare-fun <init>/-1461814690 (var2740) void)
(declare-fun var1302_setDefaultParams/-1788411937 (var2507 var876) void)
(declare-fun cast-from-var2740-to-var2507 (var2740) var2507)
(declare-fun getPort/20614931 (var876) Int)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-fun var2507_put/1464166817 (var2507 var921 var921) var921)
(declare-fun cast-from-String-to-var921 (String) var921)
(declare-fun getProtocol/491749358 (var876) String)
(declare-const null-var876 var876)
(declare-const var682 var876) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var682 null-var876)))
(define-const var230 var2740 var2740-init) ; Statement: $r0 = new java.util.LinkedHashMap 
(assert true)
;(assert (<init>/-1461814690 var230)) ; Statement: specialinvoke $r0.<java.util.LinkedHashMap: void <init>()>() 

(declare-const var230!1 var2740)
;(assert (var1302_setDefaultParams/-1788411937 (cast-from-var2740-to-var2507 var230!1) var682)) ; Statement: staticinvoke <org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils: void setDefaultParams(java.util.Map,org.apache.dubbo.common.URL)>($r0, r1) 

(declare-const var230!2 var2740)
(declare-const var682!1 var876)
(assert true)
(define-const var3787 Int (getPort/20614931 var682!1)) ; Statement: $i0 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getPort()>() 
(define-const var2113 String (String_valueOf/1240665136 var3787)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i0) 
;(assert (var2507_put/1464166817 (cast-from-var2740-to-var2507 var230!2) (cast-from-String-to-var921 "port") (cast-from-String-to-var921 var2113))) ; Statement: interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("port", $r2) 

(declare-const var230!3 var2740)
(declare-const var2163 String)
(declare-const var2113!1 String)
(assert true)
(define-const var3921 String (getProtocol/491749358 var682!1)) ; Statement: $r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
;(assert (var2507_put/1464166817 (cast-from-var2740-to-var2507 var230!3) (cast-from-String-to-var921 "protocol") (cast-from-String-to-var921 var3921))) ; Statement: interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("protocol", $r3) 

(declare-const var230!4 var2740)
(declare-const var1912 String)
(declare-const var3921!1 String)
 ; Statement: return $r0 
(check-sat)
; {var2740-init=([], java.util.LinkedHashMap), <init>/-1461814690=([java.util.LinkedHashMap], void), var1302_setDefaultParams/-1788411937=([java.util.Map, org.apache.dubbo.common.URL], void), cast-from-var2740-to-var2507=([java.util.LinkedHashMap], java.util.Map), getPort/20614931=([org.apache.dubbo.common.URL], int), String_valueOf/1240665136=([int], java.lang.String), var2507_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var921=([java.lang.String], java.lang.Object), getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String)}
; {var876=org.apache.dubbo.common.URL, var682=r1, var2740=java.util.LinkedHashMap, var230=$r0, var1302=org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils, var2507=java.util.Map, var3787=$i0, var2113=$r2, var921=java.lang.Object, var2163="port", var3921=$r3, var1912="protocol"}
; {org.apache.dubbo.common.URL=var876, r1=var682, java.util.LinkedHashMap=var2740, $r0=var230, org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils=var1302, java.util.Map=var2507, $i0=var3787, $r2=var2113, java.lang.Object=var921, "port"=var2163, $r3=var3921, "protocol"=var1912}
;seq <java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r1 := @parameter0: org.apache.dubbo.common.URL;	$r0 = new java.util.LinkedHashMap;	specialinvoke $r0.<java.util.LinkedHashMap: void <init>()>();	staticinvoke <org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils: void setDefaultParams(java.util.Map,org.apache.dubbo.common.URL)>($r0, r1);	$i0 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getPort()>();	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i0);	interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("port", $r2);	$r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("protocol", $r3);	return $r0
;block_num 1