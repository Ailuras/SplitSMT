(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var3274 0)
(declare-sort var1393 0)
(declare-sort var1403 0)
(declare-sort var1215 0)
(declare-sort var261 0)
(declare-sort var3310 0)
(declare-sort var453 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3310_convertToSplitName/-325941157 (String String) String)
(declare-fun var1215_contains/1636690605 (var1215 var453) Bool)
(declare-fun cast-from-String-to-var453 (String) var453)
(declare-const null-var3274 var3274)
(declare-const null-var1393 var1393)
(declare-const null-String String)
(declare-const var261-securityKey var1215)
(declare-const var1907 var3274) ; Statement: r5 := @parameter0: java.util.Map 
(assert (not (= var1907 null-var3274)))
(declare-const var3666 var1393) ; Statement: r6 := @parameter1: java.util.Properties 
(assert (not (= var3666 null-var1393)))
(declare-const var1074 String) ; Statement: r0 := @parameter2: java.lang.String 
(assert (not (= var1074 null-String)))
(define-const var322 Bool (ite (= 1 0) true false)) ; Statement: z1 = 0 
; split operation: var521 = var1074.split("\u005c.") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.") 
(define-const var3764 var1215 var261-securityKey) ; Statement: $r3 = <org.apache.dubbo.common.config.ConfigurationUtils: java.util.Set securityKey> 
(define-const var1904 Int (get_split_length var1074 "\u005c." -1)) ; Statement: $i0 = lengthof r1 
(define-const var2226 Int (- var1904 1)) ; Statement: $i1 = $i0 - 1 
(define-const var3421 String (get_split_element var1074 "\u005c." -1 var2226)) ; Statement: $r2 = r1[$i1] 
(define-const var1356 String (var3310_convertToSplitName/-325941157 var3421 "-")) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String convertToSplitName(java.lang.String,java.lang.String)>($r2, "-") 
(define-const var3694 Bool (var1215_contains/1636690605 var3764 (cast-from-String-to-var453 var1356))) ; Statement: $z0 = interfaceinvoke $r3.<java.util.Set: boolean contains(java.lang.Object)>($r4) 
 ; Statement: if $z0 == 0 goto (branch) 
(assert (= (ite var3694 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: if z1 != 0 goto return 
(assert (not (= (ite var322 1 0) 0))) ; Cond: z1 != 0 
 ; Statement: return 
(check-sat)
; {var3310_convertToSplitName/-325941157=([java.lang.String, java.lang.String], java.lang.String), var1215_contains/1636690605=([java.util.Set, java.lang.Object], boolean), cast-from-String-to-var453=([java.lang.String], java.lang.Object)}
; {var3274=java.util.Map, var1907=r5, var1393=java.util.Properties, var3666=r6, var1074=r0, var1403=null_type, var322=z1, var521=r1, var1215=java.util.Set, var261=org.apache.dubbo.common.config.ConfigurationUtils, var3764=$r3, var1904=$i0, var2226=$i1, var3421=$r2, var3310=org.apache.dubbo.common.utils.StringUtils, var1356=$r4, var453=java.lang.Object, var3694=$z0}
; {java.util.Map=var3274, r5=var1907, java.util.Properties=var1393, r6=var3666, r0=var1074, null_type=var1403, z1=var322, r1=var521, java.util.Set=var1215, org.apache.dubbo.common.config.ConfigurationUtils=var261, $r3=var3764, $i0=var1904, $i1=var2226, $r2=var3421, org.apache.dubbo.common.utils.StringUtils=var3310, $r4=var1356, java.lang.Object=var453, $z0=var3694}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: java.lang.String convertToSplitName(java.lang.String,java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: java.lang.String convertToSplitName(java.lang.String,java.lang.String)>": 1}
;stmts r5 := @parameter0: java.util.Map;	r6 := @parameter1: java.util.Properties;	r0 := @parameter2: java.lang.String;	z1 = 0;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.");	$r3 = <org.apache.dubbo.common.config.ConfigurationUtils: java.util.Set securityKey>;	$i0 = lengthof r1;	$i1 = $i0 - 1;	$r2 = r1[$i1];	$r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String convertToSplitName(java.lang.String,java.lang.String)>($r2, "-");	$z0 = interfaceinvoke $r3.<java.util.Set: boolean contains(java.lang.Object)>($r4);	if $z0 == 0 goto (branch);	if z1 != 0 goto return;	return
;block_num 3