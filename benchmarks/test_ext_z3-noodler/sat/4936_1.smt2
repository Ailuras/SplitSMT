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

(declare-sort var3608 0)
(declare-sort var1723 0)
(declare-sort var2326 0)
(declare-sort var1842 0)
(declare-sort var1578 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1723_getProtocolVersion/-704142115 () String)
(declare-fun var3608_put/1464166817 (var3608 var2326 var2326) var2326)
(declare-fun cast-from-String-to-var2326 (String) var2326)
(declare-fun var1723_getVersion/310196261 () String)
(declare-fun var1842_currentTimeMillis/630293680 () Int)
(declare-fun String_valueOf/-107395227 (Int) String)
(declare-fun var1578_getPid/-756941384 () Int)
(declare-const null-var3608 var3608)
(declare-const var625 var3608) ; Statement: r0 := @parameter0: java.util.Map 
(assert (not (= var625 null-var3608)))
(define-const var3683 String var1723_getProtocolVersion/-704142115) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.Version: java.lang.String getProtocolVersion()>() 
;(assert (var3608_put/1464166817 var625 (cast-from-String-to-var2326 "dubbo") (cast-from-String-to-var2326 var3683))) ; Statement: interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("dubbo", $r1) 

(declare-const var625!1 var3608)
(declare-const var2916 String)
(declare-const var3683!1 String)
(define-const var3061 String var1723_getVersion/310196261) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.Version: java.lang.String getVersion()>() 
;(assert (var3608_put/1464166817 var625!1 (cast-from-String-to-var2326 "release") (cast-from-String-to-var2326 var3061))) ; Statement: interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("release", $r2) 

(declare-const var625!2 var3608)
(declare-const var1428 String)
(declare-const var3061!1 String)
(define-const var1084 Int var1842_currentTimeMillis/630293680) ; Statement: $l0 = staticinvoke <java.lang.System: long currentTimeMillis()>() 
(define-const var2667 String (String_valueOf/-107395227 var1084)) ; Statement: $r3 = staticinvoke <java.lang.String: java.lang.String valueOf(long)>($l0) 
;(assert (var3608_put/1464166817 var625!2 (cast-from-String-to-var2326 "timestamp") (cast-from-String-to-var2326 var2667))) ; Statement: interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("timestamp", $r3) 

(declare-const var625!3 var3608)
(declare-const var619 String)
(declare-const var2667!1 String)
(define-const var231 Int var1578_getPid/-756941384) ; Statement: $i1 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: int getPid()>() 
 ; Statement: if $i1 <= 0 goto return 
(assert (<= var231 0)) ; Cond: $i1 <= 0 
 ; Statement: return 
(check-sat)
; {var1723_getProtocolVersion/-704142115=([], java.lang.String), var3608_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var2326=([java.lang.String], java.lang.Object), var1723_getVersion/310196261=([], java.lang.String), var1842_currentTimeMillis/630293680=([], long), String_valueOf/-107395227=([long], java.lang.String), var1578_getPid/-756941384=([], int)}
; {var3608=java.util.Map, var625=r0, var1723=org.apache.dubbo.common.Version, var3683=$r1, var2326=java.lang.Object, var2916="dubbo", var3061=$r2, var1428="release", var1842=java.lang.System, var1084=$l0, var2667=$r3, var619="timestamp", var1578=org.apache.dubbo.common.utils.ConfigUtils, var231=$i1}
; {java.util.Map=var3608, r0=var625, org.apache.dubbo.common.Version=var1723, $r1=var3683, java.lang.Object=var2326, "dubbo"=var2916, $r2=var3061, "release"=var1428, java.lang.System=var1842, $l0=var1084, $r3=var2667, "timestamp"=var619, org.apache.dubbo.common.utils.ConfigUtils=var1578, $i1=var231}
;seq <java.lang.String: java.lang.String valueOf(long)>
;cnt {"<java.lang.String: java.lang.String valueOf(long)>": 1}
;stmts r0 := @parameter0: java.util.Map;	$r1 = staticinvoke <org.apache.dubbo.common.Version: java.lang.String getProtocolVersion()>();	interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("dubbo", $r1);	$r2 = staticinvoke <org.apache.dubbo.common.Version: java.lang.String getVersion()>();	interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("release", $r2);	$l0 = staticinvoke <java.lang.System: long currentTimeMillis()>();	$r3 = staticinvoke <java.lang.String: java.lang.String valueOf(long)>($l0);	interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("timestamp", $r3);	$i1 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: int getPid()>();	if $i1 <= 0 goto return;	return
;block_num 2