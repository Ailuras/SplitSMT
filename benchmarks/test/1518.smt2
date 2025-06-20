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

(declare-sort var173 0)
(declare-sort var2102 0)
(declare-sort var2511 0)
(declare-sort var1851 0)
(declare-sort var125 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2511_warn/126438324 (var2511 String String String String var2102) void)
(declare-fun var125_getInstance/-1077045573 (String) var125)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const null-var2102 var2102)
(declare-const var1851-logger var2511)
(declare-const var1281 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1281 null-String)))
(declare-const var2453 Bool) ; Statement: z0 := @parameter1: boolean 
(assert (not (= var2453 null-Bool)))
 ; Statement: if z0 != 0 goto r14 = staticinvoke <org.apache.dubbo.common.cache.FileCacheStore: org.apache.dubbo.common.cache.FileCacheStore$Builder newBuilder()>() 
(assert (not (not (= (ite var2453 1 0) 0)))) ; Negate: Cond: z0 != 0  
(declare-const var3092 var2102) ; Statement: $r7 := @caughtexception 
(assert (not (= var3092 null-var2102)))
(define-const var1850 var2511 var1851-logger) ; Statement: $r9 = <org.apache.dubbo.common.cache.FileCacheStoreFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2825 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2825)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2825!1 String)
(assert (= var2825!1 ""))
(assert true)
(define-const var2985 String (append/672562846 var2825!1 "Failed to create file store cache. Local file cache will be disabled. Cache file name: ")) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to create file store cache. Local file cache will be disabled. Cache file name: ") 
(declare-const var2825!2 String)
(assert (= var2825!2 (str.++ var2825!1 "Failed to create file store cache. Local file cache will be disabled. Cache file name: ")))
(assert true)
(define-const var863 String (append/672562846 var2985 var1281)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var2985!1 String)
(assert (= var2985!1 (str.++ var2985 var1281)))
(assert true)
(define-const var259 String (toString/-2075883882 var863)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2511_warn/126438324 var1850 "0-3" "inaccessible of cache path" "" var259 var3092)) ; Statement: interfaceinvoke $r9.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-3", "inaccessible of cache path", "", $r12, $r7) 

(declare-const var1850!1 var2511)
(declare-const var2829 String)
(declare-const var146 String)
(declare-const var3956 String)
(declare-const var259!1 String)
(declare-const var3092!1 var2102)
(define-const var1211 var125 (var125_getInstance/-1077045573 var1281)) ; Statement: $r13 = staticinvoke <org.apache.dubbo.common.cache.FileCacheStore$Empty: org.apache.dubbo.common.cache.FileCacheStore$Empty getInstance(java.lang.String)>(r0) 
 ; Statement: return $r13 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2511_warn/126438324=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), var125_getInstance/-1077045573=([java.lang.String], org.apache.dubbo.common.cache.FileCacheStore$Empty)}
; {var1281=r0, var173=null_type, var2453=z0, var2102=java.lang.Throwable, var3092=$r7, var2511=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1851=org.apache.dubbo.common.cache.FileCacheStoreFactory, var1850=$r9, var2825=$r8, var2985=$r10, var863=$r11, var259=$r12, var2829="0-3", var146="inaccessible of cache path", var3956="", var125=org.apache.dubbo.common.cache.FileCacheStore$Empty, var1211=$r13}
; {r0=var1281, null_type=var173, z0=var2453, java.lang.Throwable=var2102, $r7=var3092, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2511, org.apache.dubbo.common.cache.FileCacheStoreFactory=var1851, $r9=var1850, $r8=var2825, $r10=var2985, $r11=var863, $r12=var259, "0-3"=var2829, "inaccessible of cache path"=var146, ""=var3956, org.apache.dubbo.common.cache.FileCacheStore$Empty=var125, $r13=var1211}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	z0 := @parameter1: boolean;	if z0 != 0 goto r14 = staticinvoke <org.apache.dubbo.common.cache.FileCacheStore: org.apache.dubbo.common.cache.FileCacheStore$Builder newBuilder()>();	$r7 := @caughtexception;	$r9 = <org.apache.dubbo.common.cache.FileCacheStoreFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to create file store cache. Local file cache will be disabled. Cache file name: ");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r9.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-3", "inaccessible of cache path", "", $r12, $r7);	$r13 = staticinvoke <org.apache.dubbo.common.cache.FileCacheStore$Empty: org.apache.dubbo.common.cache.FileCacheStore$Empty getInstance(java.lang.String)>(r0);	return $r13
;block_num 2