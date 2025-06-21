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

(declare-sort var2086 0)
(declare-sort var1795 0)
(declare-sort var1656 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2086_getString/-1338273427 (var2086 String) String)
(declare-fun arr-Int-init () (Array Int Int))
(declare-fun var1656_tokenize/-290051344 (String (Array Int Int)) (Array Int String))
(declare-const null-var2086 var2086)
(declare-const null-String String)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const var1565 var2086) ; Statement: r0 := @parameter0: org.apache.dubbo.common.config.Configuration 
(assert (not (= var1565 null-var2086)))
(declare-const var1534 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var1534 null-String)))
(define-const var1533 String (var2086_getString/-1338273427 var1565 var1534)) ; Statement: $r3 = interfaceinvoke r0.<org.apache.dubbo.common.config.Configuration: java.lang.String getString(java.lang.String)>(r1) 
(define-const var156 (Array Int Int) arr-Int-init) ; Statement: $r2 = newarray (char)[1] 
(declare-const var156!1 (Array Int Int))
(assert (not (= var156!1 null-__Array__Int__Int__)))
(assert (= (select var156!1 0) 44)) ; Statement: $r2[0] = 44 
(define-const var91 (Array Int String) (var1656_tokenize/-290051344 var1533 var156!1)) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] tokenize(java.lang.String,char[])>($r3, $r2) 
 ; Statement: return $r4 
(check-sat)
; {var2086_getString/-1338273427=([org.apache.dubbo.common.config.Configuration, java.lang.String], java.lang.String), arr-Int-init=([], char[]), var1656_tokenize/-290051344=([java.lang.String, char[]], java.lang.String[])}
; {var2086=org.apache.dubbo.common.config.Configuration, var1565=r0, var1534=r1, var1795=null_type, var1533=$r3, var156=$r2, var1656=org.apache.dubbo.common.utils.StringUtils, var91=$r4}
; {org.apache.dubbo.common.config.Configuration=var2086, r0=var1565, r1=var1534, null_type=var1795, $r3=var1533, $r2=var156, org.apache.dubbo.common.utils.StringUtils=var1656, $r4=var91}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] tokenize(java.lang.String,char[])>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String[] tokenize(java.lang.String,char[])>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.config.Configuration;	r1 := @parameter1: java.lang.String;	$r3 = interfaceinvoke r0.<org.apache.dubbo.common.config.Configuration: java.lang.String getString(java.lang.String)>(r1);	$r2 = newarray (char)[1];	$r2[0] = 44;	$r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] tokenize(java.lang.String,char[])>($r3, $r2);	return $r4
;block_num 1