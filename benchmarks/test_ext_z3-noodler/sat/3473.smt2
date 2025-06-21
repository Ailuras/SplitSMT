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

(declare-sort var35 0)
(declare-sort var728 0)
(declare-sort var557 0)
(declare-sort var1719 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var557) void)
(declare-fun cast-from-var35-to-var557 (var35) var557)
(declare-fun cidr/519629603 (var35) String)
(define-fun contains/1009244746 ((s String) (subs String)) Bool (str.contains s subs))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var1719-init () var1719)
(declare-fun <init>/875830710 (var1719 String) void)
(declare-const null-var35 var35)
(declare-const null-String String)
(declare-const var3455 var35) ; Statement: r0 := @this: org.apache.dubbo.common.utils.CIDRUtils 
(assert (not (= var3455 null-var35)))
(declare-const var1623 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1623 null-String)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var35-to-var557 var3455))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var3455!1 var35)
(declare-const var3455!2 var35)
(assert (not (= var3455!2 null-var35)))
(assert (= (cidr/519629603 var3455!2) var1623)) ; Statement: r0.<org.apache.dubbo.common.utils.CIDRUtils: java.lang.String cidr> = r1 
(define-const var1624 String (cidr/519629603 var3455!2)) ; Statement: $r2 = r0.<org.apache.dubbo.common.utils.CIDRUtils: java.lang.String cidr> 
(assert true)
(define-const var3340 Bool (contains/1009244746 var1624 (cast-from-String-to-String "/"))) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean contains(java.lang.CharSequence)>("/") 
 ; Statement: if $z0 == 0 goto $r3 = new java.lang.IllegalArgumentException 
(assert (= (ite var3340 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1376 var1719 var1719-init) ; Statement: $r3 = new java.lang.IllegalArgumentException 
(assert true)
;(assert (<init>/875830710 var1376 "not an valid CIDR format!")) ; Statement: specialinvoke $r3.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>("not an valid CIDR format!") 

(declare-const var1376!1 var1719)
(declare-const var1768 String)
 ; Statement: throw $r3 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var35-to-var557=([org.apache.dubbo.common.utils.CIDRUtils], java.lang.Object), cidr/519629603=([org.apache.dubbo.common.utils.CIDRUtils], java.lang.String), contains/1009244746=([java.lang.String, java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var1719-init=([], java.lang.IllegalArgumentException), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var35=org.apache.dubbo.common.utils.CIDRUtils, var3455=r0, var1623=r1, var728=null_type, var557=java.lang.Object, var1624=$r2, var3340=$z0, var1719=java.lang.IllegalArgumentException, var1376=$r3, var1768="not an valid CIDR format!"}
; {org.apache.dubbo.common.utils.CIDRUtils=var35, r0=var3455, r1=var1623, null_type=var728, java.lang.Object=var557, $r2=var1624, $z0=var3340, java.lang.IllegalArgumentException=var1719, $r3=var1376, "not an valid CIDR format!"=var1768}
;seq <java.lang.String: boolean contains(java.lang.CharSequence)>
;cnt {"<java.lang.String: boolean contains(java.lang.CharSequence)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.utils.CIDRUtils;	r1 := @parameter0: java.lang.String;	specialinvoke r0.<java.lang.Object: void <init>()>();	r0.<org.apache.dubbo.common.utils.CIDRUtils: java.lang.String cidr> = r1;	$r2 = r0.<org.apache.dubbo.common.utils.CIDRUtils: java.lang.String cidr>;	$z0 = virtualinvoke $r2.<java.lang.String: boolean contains(java.lang.CharSequence)>("/");	if $z0 == 0 goto $r3 = new java.lang.IllegalArgumentException;	$r3 = new java.lang.IllegalArgumentException;	specialinvoke $r3.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>("not an valid CIDR format!");	throw $r3
;block_num 2