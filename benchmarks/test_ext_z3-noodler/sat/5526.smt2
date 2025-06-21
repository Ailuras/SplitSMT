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

(declare-sort var2935 0)
(declare-sort var2662 0)
(declare-sort var2116 0)
(declare-sort var1988 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2662_isEmpty/-813097145 (String) Bool)
(declare-fun var2662_splitToList0/-1913919303 (String Int) var2116)
(declare-fun var2116_toArray/-775711681 (var2116 (Array Int var1988)) (Array Int var1988))
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var1988__ ((Array Int String)) (Array Int var1988))
(declare-fun cast-from-__Array__Int__var1988__-to-__Array__Int__String__ ((Array Int var1988)) (Array Int String))
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2662-EMPTY_STRING_ARRAY (Array Int String))
(declare-const var1497 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1497 null-String)))
(declare-const var141 Int) ; Statement: c0 := @parameter1: char 
(assert (not (= var141 null-Int)))
(define-const var2348 Bool (var2662_isEmpty/-813097145 var1497)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList0(java.lang.String,char)>(r0, c0) 
(assert (= (ite var2348 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2957 var2116 (var2662_splitToList0/-1913919303 var1497 var141)) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList0(java.lang.String,char)>(r0, c0) 
(define-const var1883 (Array Int String) var2662-EMPTY_STRING_ARRAY) ; Statement: $r1 = <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] EMPTY_STRING_ARRAY> 
(define-const var768 (Array Int var1988) (var2116_toArray/-775711681 var2957 (cast-from-__Array__Int__String__-to-__Array__Int__var1988__ var1883))) ; Statement: $r3 = interfaceinvoke $r2.<java.util.List: java.lang.Object[] toArray(java.lang.Object[])>($r1) 
(define-const var739 (Array Int String) (cast-from-__Array__Int__var1988__-to-__Array__Int__String__ var768)) ; Statement: $r4 = (java.lang.String[]) $r3 
 ; Statement: return $r4 
(check-sat)
; {var2662_isEmpty/-813097145=([java.lang.String], boolean), var2662_splitToList0/-1913919303=([java.lang.String, char], java.util.List), var2116_toArray/-775711681=([java.util.List, java.lang.Object[]], java.lang.Object[]), cast-from-__Array__Int__String__-to-__Array__Int__var1988__=([java.lang.String[]], java.lang.Object[]), cast-from-__Array__Int__var1988__-to-__Array__Int__String__=([java.lang.Object[]], java.lang.String[])}
; {var1497=r0, var2935=null_type, var141=c0, var2662=org.apache.dubbo.common.utils.StringUtils, var2348=$z0, var2116=java.util.List, var2957=$r2, var1883=$r1, var1988=java.lang.Object, var768=$r3, var739=$r4}
; {r0=var1497, null_type=var2935, c0=var141, org.apache.dubbo.common.utils.StringUtils=var2662, $z0=var2348, java.util.List=var2116, $r2=var2957, $r1=var1883, java.lang.Object=var1988, $r3=var768, $r4=var739}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList0(java.lang.String,char)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList0(java.lang.String,char)>": 1}
;stmts r0 := @parameter0: java.lang.String;	c0 := @parameter1: char;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList0(java.lang.String,char)>(r0, c0);	$r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList0(java.lang.String,char)>(r0, c0);	$r1 = <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] EMPTY_STRING_ARRAY>;	$r3 = interfaceinvoke $r2.<java.util.List: java.lang.Object[] toArray(java.lang.Object[])>($r1);	$r4 = (java.lang.String[]) $r3;	return $r4
;block_num 2