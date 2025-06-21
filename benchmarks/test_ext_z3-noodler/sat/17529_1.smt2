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

(declare-sort var255 0)
(declare-sort var2947 0)
(declare-sort var889 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-Int-init () (Array Int Int))
(declare-fun var2947_tokenize/-290051344 (String (Array Int Int)) (Array Int String))
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(declare-fun var889-init () var889)
(declare-fun <init>/1336938971 (var889 String String) void)
(declare-const null-String String)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const var1665 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1665 null-String)))
(define-const var141 (Array Int Int) arr-Int-init) ; Statement: $r1 = newarray (char)[2] 
(declare-const var141!1 (Array Int Int))
(assert (not (= var141!1 null-__Array__Int__Int__)))
(assert (= (select var141!1 0) 45)) ; Statement: $r1[0] = 45 
(declare-const var141!2 (Array Int Int))
(assert (not (= var141!2 null-__Array__Int__Int__)))
(assert (= (select var141!2 1) 95)) ; Statement: $r1[1] = 95 
(define-const var3498 (Array Int String) (var2947_tokenize/-290051344 var1665 var141!2)) ; Statement: r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] tokenize(java.lang.String,char[])>(r0, $r1) 
(define-const var935 Int (getLength-Arr-String-1 var3498)) ; Statement: $i0 = lengthof r2 
 ; Statement: lookupswitch($i0) {     case 2: goto $r7 = new java.util.Locale;     case 3: goto $r3 = new java.util.Locale;     default: goto $r10 = new java.util.Locale; } 
(assert (and (= var935 2) true)) ; Intersect: Cond: $i0 == 2  and Non Conditional 
(define-const var3868 var889 var889-init) ; Statement: $r7 = new java.util.Locale 
(define-const var2449 String (select var3498 0)) ; Statement: $r9 = r2[0] 
(define-const var410 String (select var3498 1)) ; Statement: $r8 = r2[1] 
(assert true)
;(assert (<init>/1336938971 var3868 var2449 var410)) ; Statement: specialinvoke $r7.<java.util.Locale: void <init>(java.lang.String,java.lang.String)>($r9, $r8) 

(declare-const var3868!1 var889)
(declare-const var2449!1 String)
(declare-const var410!1 String)
 ; Statement: return $r7 
(check-sat)
; {arr-Int-init=([], char[]), var2947_tokenize/-290051344=([java.lang.String, char[]], java.lang.String[]), getLength-Arr-String-1=([java.lang.String[]], int), var889-init=([], java.util.Locale), <init>/1336938971=([java.util.Locale, java.lang.String, java.lang.String], void)}
; {var1665=r0, var255=null_type, var141=$r1, var2947=org.apache.dubbo.common.utils.StringUtils, var3498=r2, var935=$i0, var889=java.util.Locale, var3868=$r7, var2449=$r9, var410=$r8}
; {r0=var1665, null_type=var255, $r1=var141, org.apache.dubbo.common.utils.StringUtils=var2947, r2=var3498, $i0=var935, java.util.Locale=var889, $r7=var3868, $r9=var2449, $r8=var410}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] tokenize(java.lang.String,char[])>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String[] tokenize(java.lang.String,char[])>": 1}
;stmts r0 := @parameter0: java.lang.String;	$r1 = newarray (char)[2];	$r1[0] = 45;	$r1[1] = 95;	r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] tokenize(java.lang.String,char[])>(r0, $r1);	$i0 = lengthof r2;	lookupswitch($i0) {     case 2: goto $r7 = new java.util.Locale;     case 3: goto $r3 = new java.util.Locale;     default: goto $r10 = new java.util.Locale; };	$r7 = new java.util.Locale;	$r9 = r2[0];	$r8 = r2[1];	specialinvoke $r7.<java.util.Locale: void <init>(java.lang.String,java.lang.String)>($r9, $r8);	return $r7
;block_num 2