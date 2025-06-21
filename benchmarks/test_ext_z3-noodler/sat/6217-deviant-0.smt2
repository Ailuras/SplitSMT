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

(declare-sort var2732 0)
(declare-sort var1445 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1445_isEmpty/-813097145 (String) Bool)
(declare-fun var1445_isWord/850164166 (String) Bool)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(declare-fun var1445_isSplitCase/409736578 (String Int) Bool)
(define-fun toLowerCase/415700667 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "A" "a") "B" "b") "C" "c") "D" "d") "E" "e") "F" "f") "G" "g") "H" "h") "I" "i") "J" "j") "K" "k") "L" "l") "M" "m") "N" "n") "O" "o") "P" "p") "Q" "q") "R" "r") "S" "s") "T" "t") "U" "u") "V" "v") "W" "w") "X" "x") "Y" "y") "Z" "z"))
(declare-const null-String String)
(declare-const var1545 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1545 null-String)))
(declare-const var2922 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2922 null-String)))
(define-const var360 Bool (var1445_isEmpty/-813097145 var1545)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isWord(java.lang.String)>(r0) 
(assert (= (ite var360 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3598 Bool (var1445_isWord/850164166 var1545)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isWord(java.lang.String)>(r0) 
 ; Statement: if $z1 != 0 goto r5 = null 
(assert (not (not (= (ite var3598 1 0) 0)))) ; Negate: Cond: $z1 != 0  
(assert (not (and true (and (> (str.len var2922) 0) (<= 0 0)))))
(check-sat)
; {var1445_isEmpty/-813097145=([java.lang.String], boolean), var1445_isWord/850164166=([java.lang.String], boolean), charAt/698050440=([java.lang.String, int], char), var1445_isSplitCase/409736578=([java.lang.String, char], boolean), toLowerCase/415700667=([java.lang.String], java.lang.String)}
; {var1545=r0, var2732=null_type, var2922=r2, var1445=org.apache.dubbo.common.utils.StringUtils, var360=$z0, var3598=$z1, var2262=$c3, var1925=$z2, var465=$r4}
; {r0=var1545, null_type=var2732, r2=var2922, org.apache.dubbo.common.utils.StringUtils=var1445, $z0=var360, $z1=var3598, $c3=var2262, $z2=var1925, $r4=var465}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isWord(java.lang.String)>;	<java.lang.String: char charAt(int)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isSplitCase(java.lang.String,char)>;	<java.lang.String: java.lang.String toLowerCase()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isWord(java.lang.String)>": 1,"<java.lang.String: char charAt(int)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isSplitCase(java.lang.String,char)>": 1,"<java.lang.String: java.lang.String toLowerCase()>": 1}
;stmts r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isWord(java.lang.String)>(r0);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isWord(java.lang.String)>(r0);	if $z1 != 0 goto r5 = null;	$c3 = virtualinvoke r2.<java.lang.String: char charAt(int)>(0);	$z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isSplitCase(java.lang.String,char)>(r0, $c3);	if $z2 == 0 goto return r0;	$r4 = virtualinvoke r0.<java.lang.String: java.lang.String toLowerCase()>();	return $r4
;block_num 4