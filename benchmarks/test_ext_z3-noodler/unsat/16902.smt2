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

(declare-sort var1473 0)
(declare-sort var2312 0)
(declare-sort var446 0)
(declare-sort var1409 0)
(declare-sort var965 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2312_getSystemProperty/1393069448 (String) String)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var446_isNotEmpty/-1251449450 (String) Bool)
(declare-fun getParameter/448702405 (var1473 String Int) Int)
(declare-fun var1409_getHeartbeat/-289072484 (var1473) Int)
(declare-fun var965-init () var965)
(declare-fun <init>/-1092629202 (var965 String) void)
(declare-const null-var1473 var1473)
(declare-const var3040 var1473) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3040 null-var1473)))
(define-const var368 String (var2312_getSystemProperty/1393069448 "dubbo.protocol.default-close-timeout")) ; Statement: r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.protocol.default-close-timeout") 
(define-const var2000 Int (cast-from-Int-to-Int -1)) ; Statement: $i5 = (int) -1 
(define-const var2859 Int var2000) ; Statement: i3 = $i5 
(define-const var218 Bool (var446_isNotEmpty/-1251449450 var368)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto (branch) 
(assert (= (ite var218 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: if i3 >= 0 goto $i1 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("close.timeout", i3) 
(assert (>= var2859 0)) ; Cond: i3 >= 0 
(assert true)
(define-const var402 Int (getParameter/448702405 var3040 "close.timeout" var2859)) ; Statement: $i1 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("close.timeout", i3) 
(define-const var2895 Int (var1409_getHeartbeat/-289072484 var3040)) ; Statement: $i2 = staticinvoke <org.apache.dubbo.remoting.utils.UrlUtils: int getHeartbeat(org.apache.dubbo.common.URL)>(r1) 
(define-const var1338 Int (* var2895 2)) ; Statement: $i0 = $i2 * 2 
 ; Statement: if $i1 >= $i0 goto return $i1 
(assert (not (>= var402 var1338))) ; Negate: Cond: $i1 >= $i0  
(define-const var2990 var965 var965-init) ; Statement: $r4 = new java.lang.IllegalStateException 
(assert true)
;(assert (<init>/-1092629202 var2990 "closeTimeout < heartbeatInterval * 2")) ; Statement: specialinvoke $r4.<java.lang.IllegalStateException: void <init>(java.lang.String)>("closeTimeout < heartbeatInterval * 2") 

(declare-const var2990!1 var965)
(declare-const var3625 String)
 ; Statement: throw $r4 
(check-sat)
; {var2312_getSystemProperty/1393069448=([java.lang.String], java.lang.String), cast-from-Int-to-Int=([int], int), var446_isNotEmpty/-1251449450=([java.lang.String], boolean), getParameter/448702405=([org.apache.dubbo.common.URL, java.lang.String, int], int), var1409_getHeartbeat/-289072484=([org.apache.dubbo.common.URL], int), var965-init=([], java.lang.IllegalStateException), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var1473=org.apache.dubbo.common.URL, var3040=r1, var2312=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var368=r0, var2000=$i5, var2859=i3, var446=org.apache.dubbo.common.utils.StringUtils, var218=$z0, var402=$i1, var1409=org.apache.dubbo.remoting.utils.UrlUtils, var2895=$i2, var1338=$i0, var965=java.lang.IllegalStateException, var2990=$r4, var3625="closeTimeout < heartbeatInterval * 2"}
; {org.apache.dubbo.common.URL=var1473, r1=var3040, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var2312, r0=var368, $i5=var2000, i3=var2859, org.apache.dubbo.common.utils.StringUtils=var446, $z0=var218, $i1=var402, org.apache.dubbo.remoting.utils.UrlUtils=var1409, $i2=var2895, $i0=var1338, java.lang.IllegalStateException=var965, $r4=var2990, "closeTimeout < heartbeatInterval * 2"=var3625}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @parameter0: org.apache.dubbo.common.URL;	r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.protocol.default-close-timeout");	$i5 = (int) -1;	i3 = $i5;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto (branch);	if i3 >= 0 goto $i1 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("close.timeout", i3);	$i1 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("close.timeout", i3);	$i2 = staticinvoke <org.apache.dubbo.remoting.utils.UrlUtils: int getHeartbeat(org.apache.dubbo.common.URL)>(r1);	$i0 = $i2 * 2;	if $i1 >= $i0 goto return $i1;	$r4 = new java.lang.IllegalStateException;	specialinvoke $r4.<java.lang.IllegalStateException: void <init>(java.lang.String)>("closeTimeout < heartbeatInterval * 2");	throw $r4
;block_num 4