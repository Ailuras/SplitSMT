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

(declare-sort var1624 0)
(declare-sort var1255 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1255_isEmpty/-813097145 (String) Bool)
(declare-fun var1255_isWord/850164166 (String) Bool)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(declare-fun var1255_isSplitCase/409736578 (String Int) Bool)
(declare-const null-String String)
(declare-const var3382 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3382 null-String)))
(declare-const var3933 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3933 null-String)))
(define-const var1427 Bool (var1255_isEmpty/-813097145 var3382)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isWord(java.lang.String)>(r0) 
(assert (= (ite var1427 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2302 Bool (var1255_isWord/850164166 var3382)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isWord(java.lang.String)>(r0) 
 ; Statement: if $z1 != 0 goto r5 = null 
(assert (not (not (= (ite var2302 1 0) 0)))) ; Negate: Cond: $z1 != 0  
(assert (not (and true (and (> (str.len var3933) 0) (<= 0 0)))))
(check-sat)
; {var1255_isEmpty/-813097145=([java.lang.String], boolean), var1255_isWord/850164166=([java.lang.String], boolean), charAt/698050440=([java.lang.String, int], char), var1255_isSplitCase/409736578=([java.lang.String, char], boolean)}
; {var3382=r0, var1624=null_type, var3933=r2, var1255=org.apache.dubbo.common.utils.StringUtils, var1427=$z0, var2302=$z1, var1156=$c3, var1670=$z2}
; {r0=var3382, null_type=var1624, r2=var3933, org.apache.dubbo.common.utils.StringUtils=var1255, $z0=var1427, $z1=var2302, $c3=var1156, $z2=var1670}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isWord(java.lang.String)>;	<java.lang.String: char charAt(int)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isSplitCase(java.lang.String,char)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isWord(java.lang.String)>": 1,"<java.lang.String: char charAt(int)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isSplitCase(java.lang.String,char)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isWord(java.lang.String)>(r0);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isWord(java.lang.String)>(r0);	if $z1 != 0 goto r5 = null;	$c3 = virtualinvoke r2.<java.lang.String: char charAt(int)>(0);	$z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isSplitCase(java.lang.String,char)>(r0, $c3);	if $z2 == 0 goto return r0;	return r0
;block_num 4