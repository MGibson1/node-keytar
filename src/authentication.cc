#include "authentication.h"

std::string auth("_auth");
std::string biometric("_biometric");

bool ShouldAuthenticatePresence(const std::string &service,
                                const std::string &account,
                                std::string *error)
{
    return service.find(auth) != std::string::npos ||
           account.find(auth) != std::string::npos ||
           service.find(biometric) != std::string::npos ||
           account.find(biometric) != std::string::npos;
}
