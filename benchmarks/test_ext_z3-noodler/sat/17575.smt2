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

(declare-sort var3959 0)
(declare-sort var2870 0)
(declare-sort var415 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-Int-init () (Array Int Int))
(declare-fun var2870_tokenize/-290051344 (String (Array Int Int)) (Array Int String))
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(declare-fun var415-init () var415)
(declare-fun <init>/492115872 (var415 String String String) void)
(declare-const null-String String)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const var2690 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2690 null-String)))
(define-const var570 (Array Int Int) arr-Int-init) ; Statement: $r1 = newarray (char)[2] 
(declare-const var570!1 (Array Int Int))
(assert (not (= var570!1 null-__Array__Int__Int__)))
(assert (= (select var570!1 0) 45)) ; Statement: $r1[0] = 45 
(declare-const var570!2 (Array Int Int))
(assert (not (= var570!2 null-__Array__Int__Int__)))
(assert (= (select var570!2 1) 95)) ; Statement: $r1[1] = 95 
(define-const var1906 (Array Int String) (var2870_tokenize/-290051344 var2690 var570!2)) ; Statement: r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] tokenize(java.lang.String,char[])>(r0, $r1) 
(define-const var362 Int (getLength-Arr-String-1 var1906)) ; Statement: $i0 = lengthof r2 
 ; Statement: lookupswitch($i0) {     case 2: goto $r7 = new java.util.Locale;     case 3: goto $r3 = new java.util.Locale;     default: goto $r10 = new java.util.Locale; } 
(assert (and (= var362 3) (and (not (= var362 2)) true))) ; Intersect: Cond: $i0 == 3  and Intersect: Negate: Cond: $i0 == 2   and Non Conditional  
(define-const var769 var415 var415-init) ; Statement: $r3 = new java.util.Locale 
(define-const var2442 String (select var1906 0)) ; Statement: $r6 = r2[0] 
(define-const var2749 String (select var1906 1)) ; Statement: $r5 = r2[1] 
(define-const var3444 String (select var1906 2)) ; Statement: $r4 = r2[2] 
(assert true)
;(assert (<init>/492115872 var769 var2442 var2749 var3444)) ; Statement: specialinvoke $r3.<java.util.Locale: void <init>(java.lang.String,java.lang.String,java.lang.String)>($r6, $r5, $r4) 

(declare-const var769!1 var415)
(declare-const var2442!1 String)
(declare-const var2749!1 String)
(declare-const var3444!1 String)
 ; Statement: return $r3 
(check-sat)
; {arr-Int-init=([], char[]), var2870_tokenize/-290051344=([java.lang.String, char[]], java.lang.String[]), getLength-Arr-String-1=([java.lang.String[]], int), var415-init=([], java.util.Locale), <init>/492115872=([java.util.Locale, java.lang.String, java.lang.String, java.lang.String], void)}
; {var2690=r0, var3959=null_type, var570=$r1, var2870=org.apache.dubbo.common.utils.StringUtils, var1906=r2, var362=$i0, var415=java.util.Locale, var769=$r3, var2442=$r6, var2749=$r5, var3444=$r4}
; {r0=var2690, null_type=var3959, $r1=var570, org.apache.dubbo.common.utils.StringUtils=var2870, r2=var1906, $i0=var362, java.util.Locale=var415, $r3=var769, $r6=var2442, $r5=var2749, $r4=var3444}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] tokenize(java.lang.String,char[])>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String[] tokenize(java.lang.String,char[])>": 1}
;stmts r0 := @parameter0: java.lang.String;	$r1 = newarray (char)[2];	$r1[0] = 45;	$r1[1] = 95;	r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] tokenize(java.lang.String,char[])>(r0, $r1);	$i0 = lengthof r2;	lookupswitch($i0) {     case 2: goto $r7 = new java.util.Locale;     case 3: goto $r3 = new java.util.Locale;     default: goto $r10 = new java.util.Locale; };	$r3 = new java.util.Locale;	$r6 = r2[0];	$r5 = r2[1];	$r4 = r2[2];	specialinvoke $r3.<java.util.Locale: void <init>(java.lang.String,java.lang.String,java.lang.String)>($r6, $r5, $r4);	return $r3
;block_num 2