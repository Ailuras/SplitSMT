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

(declare-sort var3786 0)
(declare-sort var2761 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun contains/1009244746 ((s String) (subs String)) Bool (str.contains s subs))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var2761-init () var2761)
(declare-fun <init>/-466921135 (var2761 String) void)
(declare-fun isInRange/799420025 (var2761 String) Bool)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var1573 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1573 null-String)))
(declare-const var507 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var507 null-String)))
(declare-const var2178 Int) ; Statement: i0 := @parameter2: int 
(assert (not (= var2178 null-Int)))
(assert true)
(define-const var3409 Bool (contains/1009244746 var1573 (cast-from-String-to-String "/"))) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean contains(java.lang.CharSequence)>("/") 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: boolean matchIpRange(java.lang.String,java.lang.String,int)>(r0, r1, i0) 
(assert (not (= (ite var3409 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3901 var2761 var2761-init) ; Statement: $r2 = new org.apache.dubbo.common.utils.CIDRUtils 
(assert true)
;(assert (<init>/-466921135 var3901 var1573)) ; Statement: specialinvoke $r2.<org.apache.dubbo.common.utils.CIDRUtils: void <init>(java.lang.String)>(r0) 

(declare-const var3901!1 var2761)
(declare-const var1573!1 String)
(assert true)
(define-const var892 Bool (isInRange/799420025 var3901!1 var507)) ; Statement: $z2 = virtualinvoke $r2.<org.apache.dubbo.common.utils.CIDRUtils: boolean isInRange(java.lang.String)>(r1) 
 ; Statement: return $z2 
(check-sat)
; {contains/1009244746=([java.lang.String, java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var2761-init=([], org.apache.dubbo.common.utils.CIDRUtils), <init>/-466921135=([org.apache.dubbo.common.utils.CIDRUtils, java.lang.String], void), isInRange/799420025=([org.apache.dubbo.common.utils.CIDRUtils, java.lang.String], boolean)}
; {var1573=r0, var3786=null_type, var507=r1, var2178=i0, var3409=$z0, var2761=org.apache.dubbo.common.utils.CIDRUtils, var3901=$r2, var892=$z2}
; {r0=var1573, null_type=var3786, r1=var507, i0=var2178, $z0=var3409, org.apache.dubbo.common.utils.CIDRUtils=var2761, $r2=var3901, $z2=var892}
;seq <java.lang.String: boolean contains(java.lang.CharSequence)>
;cnt {"<java.lang.String: boolean contains(java.lang.CharSequence)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	i0 := @parameter2: int;	$z0 = virtualinvoke r0.<java.lang.String: boolean contains(java.lang.CharSequence)>("/");	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: boolean matchIpRange(java.lang.String,java.lang.String,int)>(r0, r1, i0);	$r2 = new org.apache.dubbo.common.utils.CIDRUtils;	specialinvoke $r2.<org.apache.dubbo.common.utils.CIDRUtils: void <init>(java.lang.String)>(r0);	$z2 = virtualinvoke $r2.<org.apache.dubbo.common.utils.CIDRUtils: boolean isInRange(java.lang.String)>(r1);	return $z2
;block_num 2